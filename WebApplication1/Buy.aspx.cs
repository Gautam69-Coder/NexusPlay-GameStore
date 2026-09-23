using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace WebApplication1
{
    public class PurchasedKeyItem
    {
        public string Title { get; set; }
        public string Platform { get; set; }
        public string LicenseType { get; set; }
        public string Key { get; set; }
    }

    public partial class Buy : Page
    {
        SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
        SqlCommand co = new SqlCommand();
        SqlDataReader ds;

        public string CartBadgeCssClass { get; set; } = string.Empty;
        private string _gameId = string.Empty;
        private string _actionType = "buy";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (cn.State == ConnectionState.Closed)
                cn.Open();
            co.Connection = cn;

            var currentUser = AuthHelper.GetCurrentUser(Request);
            if (currentUser == null)
            {
                Response.Redirect("Signin.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            int userId = currentUser.UserId;
            _gameId = Request.QueryString["id"] ?? string.Empty;
            _actionType = Request.QueryString["action"] ?? "buy";

            litNavUsername.Text = currentUser.Username;

            // Sync cart count
            int cartCount = GetCartCount(userId);
            litNavCartCount.Text = cartCount.ToString();
            if (cartCount > 0) CartBadgeCssClass = "has-items";

            if (!IsPostBack)
            {
                if (string.IsNullOrEmpty(txtDeliveryEmail.Text))
                {
                    txtDeliveryEmail.Text = currentUser.Email;
                }

                if (!string.IsNullOrEmpty(_gameId))
                {
                    LoadSingleGameDetails(_gameId, _actionType);
                }
                else
                {
                    LoadCartCheckoutDetails(userId);
                }
            }
        }

        private int GetCartCount(int userId)
        {
            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = "select isnull(sum(quantity), 0) from [dbo].[cart] where user_id=" + userId;
                object res = co.ExecuteScalar();
                return res != null ? Convert.ToInt32(res) : 0;
            }
            catch
            {
                return 0;
            }
        }

        private void LoadSingleGameDetails(string gameCode, string action)
        {
            phSingleItem.Visible = true;
            phCartItems.Visible = false;

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = "select top 1 id, game_code, title, buy_price, rent_price, platforms, image_url from [dbo].[games] where game_code='" + gameCode.Replace("'", "''") + "' or cast(id as nvarchar)='" + gameCode.Replace("'", "''") + "'";
                ds = co.ExecuteReader();

                if (ds.Read())
                {
                    string title = ds["title"].ToString();
                    string img = ds["image_url"] != DBNull.Value ? ds["image_url"].ToString() : "images/hero-banner.jpg";
                    string platforms = ds["platforms"] != DBNull.Value ? ds["platforms"].ToString() : "Steam / PC";

                    bool isRent = action.Equals("rent", StringComparison.OrdinalIgnoreCase);
                    decimal price = isRent ? Convert.ToDecimal(ds["rent_price"]) : Convert.ToDecimal(ds["buy_price"]);

                    lblSingleTypeBadge.Text = isRent ? "7-Day Rental Pass" : "Permanent DRM Key";
                    lblSingleTypeBadge.CssClass = isRent ? "badge-license-rent" : "badge-license-buy";

                    imgSingleGame.ImageUrl = img;
                    litSingleTitle.Text = title;
                    litSinglePlatform.Text = platforms;
                    litSinglePrice.Text = price.ToString("F2");
                    litSubtotal.Text = price.ToString("F2");
                    litTotal.Text = price.ToString("F2");
                }
                else
                {
                    Response.Redirect("Home.aspx#featuredGames");
                }
                ds.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading game details: " + ex.Message);
            }
        }

        private void LoadCartCheckoutDetails(int userId)
        {
            phSingleItem.Visible = false;
            phCartItems.Visible = true;

            DataTable dt = new DataTable();
            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = "select id, game_id, game_code, title, license_type, price, platform, quantity from [dbo].[cart] where user_id=" + userId + " order by id asc";
                ds = co.ExecuteReader();
                dt.Load(ds);
                ds.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading cart: " + ex.Message);
            }

            if (dt.Rows.Count == 0)
            {
                Response.Redirect("Cart.aspx");
                return;
            }

            decimal subtotal = 0m;
            foreach (DataRow row in dt.Rows)
            {
                int qty = Convert.ToInt32(row["quantity"]);
                decimal p = Convert.ToDecimal(row["price"]);
                subtotal += (p * qty);
            }

            litSubtotal.Text = subtotal.ToString("F2");
            litTotal.Text = subtotal.ToString("F2");

            rptCartSummary.DataSource = dt;
            rptCartSummary.DataBind();
        }

        protected void btnConfirmPurchase_Click(object sender, EventArgs e)
        {
            var currentUser = AuthHelper.GetCurrentUser(Request);
            if (currentUser == null)
            {
                Response.Redirect("Signin.aspx");
                return;
            }

            int userId = currentUser.UserId;
            string deliveryEmail = !string.IsNullOrWhiteSpace(txtDeliveryEmail.Text) ? txtDeliveryEmail.Text.Trim() : (currentUser.Email ?? "customer@nexus.gg");
            string platform = ddlPlatform.SelectedValue ?? "Steam (PC)";
            string paymentMethod = hfSelectedPayment.Value ?? "card";

            var rnd = new Random();
            string orderNumber = "#NX-" + rnd.Next(100000, 999999).ToString();

            var purchasedKeys = new List<PurchasedKeyItem>();

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();

                using (SqlTransaction tran = cn.BeginTransaction())
                {
                    co.Connection = cn;
                    co.Transaction = tran;

                    try
                    {
                        decimal subtotal = 0m;
                        decimal discount = 0m;
                        decimal total = 0m;

                        var itemsToInsert = new List<OrderItemToPersist>();

                        if (!string.IsNullOrEmpty(_gameId))
                        {
                            // Single Game Purchase Mode
                            co.CommandText = "select top 1 id, title, buy_price, rent_price, platforms from [dbo].[games] where game_code='" + _gameId.Replace("'", "''") + "' or cast(id as nvarchar)='" + _gameId.Replace("'", "''") + "'";
                            ds = co.ExecuteReader();

                            if (ds.Read())
                            {
                                int gamePk = Convert.ToInt32(ds["id"]);
                                string title = ds["title"].ToString();
                                bool isRent = _actionType.Equals("rent", StringComparison.OrdinalIgnoreCase);
                                decimal price = isRent ? Convert.ToDecimal(ds["rent_price"]) : Convert.ToDecimal(ds["buy_price"]);
                                string lic = isRent ? "7-Day Rental Pass" : "Permanent DRM Key";

                                subtotal = price;
                                total = price;

                                itemsToInsert.Add(new OrderItemToPersist
                                {
                                    GameId = gamePk,
                                    Title = title,
                                    LicenseType = lic,
                                    Price = price,
                                    Platform = platform,
                                    Key = GenerateActivationKey()
                                });
                            }
                            ds.Close();
                        }
                        else
                        {
                            // Cart Checkout Mode
                            co.CommandText = "select game_id, title, license_type, price, platform, quantity from [dbo].[cart] where user_id=" + userId;
                            ds = co.ExecuteReader();
                            var tempCart = new List<Tuple<int?, string, string, decimal, string, int>>();

                            while (ds.Read())
                            {
                                int? gId = ds["game_id"] != DBNull.Value ? (int?)Convert.ToInt32(ds["game_id"]) : null;
                                string title = ds["title"].ToString();
                                string lic = ds["license_type"].ToString();
                                decimal price = Convert.ToDecimal(ds["price"]);
                                string itemPlatform = ds["platform"] != DBNull.Value ? ds["platform"].ToString() : platform;
                                int qty = Convert.ToInt32(ds["quantity"]);
                                tempCart.Add(Tuple.Create(gId, title, lic, price, itemPlatform, qty));
                            }
                            ds.Close();

                            foreach (var cartRow in tempCart)
                            {
                                for (int i = 0; i < cartRow.Item6; i++)
                                {
                                    subtotal += cartRow.Item4;
                                    itemsToInsert.Add(new OrderItemToPersist
                                    {
                                        GameId = cartRow.Item1,
                                        Title = cartRow.Item2,
                                        LicenseType = cartRow.Item3.Equals("Rent", StringComparison.OrdinalIgnoreCase) ? "7-Day Rental Pass" : "Permanent DRM Key",
                                        Price = cartRow.Item4,
                                        Platform = cartRow.Item5,
                                        Key = GenerateActivationKey()
                                    });
                                }
                            }

                            total = subtotal - discount;
                        }

                        if (itemsToInsert.Count == 0)
                        {
                            throw new Exception("No valid items found for checkout.");
                        }

                        // 1. Insert Order
                        co.CommandText = "insert into [dbo].[orders] (order_number, user_id, customer_email, target_platform, payment_method, subtotal, discount, total_amount, order_status) output inserted.id values ('" + orderNumber + "', " + userId + ", '" + deliveryEmail.Replace("'", "''") + "', '" + platform.Replace("'", "''") + "', '" + paymentMethod.Replace("'", "''") + "', " + subtotal + ", " + discount + ", " + total + ", 'Completed')";
                        int newOrderId = Convert.ToInt32(co.ExecuteScalar());

                        // 2. Insert Order Items & Keys
                        foreach (var item in itemsToInsert)
                        {
                            string gameIdVal = item.GameId.HasValue ? item.GameId.Value.ToString() : "NULL";
                            co.CommandText = "insert into [dbo].[order_items] (order_id, game_id, game_title, license_type, price, platform, activation_key) values (" + newOrderId + ", " + gameIdVal + ", '" + item.Title.Replace("'", "''") + "', '" + item.LicenseType.Replace("'", "''") + "', " + item.Price + ", '" + item.Platform.Replace("'", "''") + "', '" + item.Key.Replace("'", "''") + "')";
                            co.ExecuteNonQuery();

                            purchasedKeys.Add(new PurchasedKeyItem
                            {
                                Title = item.Title,
                                Platform = item.Platform,
                                LicenseType = item.LicenseType,
                                Key = item.Key
                            });
                        }

                        // 3. Insert Transaction Record into transaction_history
                        string txnId = "TXN-" + rnd.Next(10000000, 99999999).ToString();
                        string cardLast4 = paymentMethod.Equals("card", StringComparison.OrdinalIgnoreCase) ? "4242" : "N/A";
                        co.CommandText = "insert into [dbo].[transaction_history] (transaction_id, order_id, order_number, user_id, amount, payment_method, payment_status, card_last4) values ('" + txnId + "', " + newOrderId + ", '" + orderNumber + "', " + userId + ", " + total + ", '" + paymentMethod.Replace("'", "''") + "', 'Success', '" + cardLast4 + "')";
                        co.ExecuteNonQuery();

                        // 4. Clear Cart
                        if (string.IsNullOrEmpty(_gameId))
                        {
                            co.CommandText = "delete from [dbo].[cart] where user_id=" + userId;
                            co.ExecuteNonQuery();
                        }

                        tran.Commit();
                    }
                    catch (Exception)
                    {
                        tran.Rollback();
                        throw;
                    }
                }

                // Show confirmation panel
                pnlCheckoutForm.Visible = false;
                pnlOrderSuccess.Visible = true;

                litOrderId.Text = orderNumber;
                litSuccessEmail.Text = deliveryEmail;

                rptKeys.DataSource = purchasedKeys;
                rptKeys.DataBind();

                litNavCartCount.Text = "0";
                CartBadgeCssClass = "";
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Purchase error: " + ex.Message);
            }
        }

        private string GenerateActivationKey()
        {
            var rnd = new Random(Guid.NewGuid().GetHashCode());
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
            Func<int, string> randomString = len =>
                new string(Enumerable.Repeat(chars, len).Select(s => s[rnd.Next(s.Length)]).ToArray());

            return $"NXUS-{randomString(4)}-{randomString(4)}-{randomString(4)}";
        }

        private class OrderItemToPersist
        {
            public int? GameId { get; set; }
            public string Title { get; set; }
            public string LicenseType { get; set; }
            public decimal Price { get; set; }
            public string Platform { get; set; }
            public string Key { get; set; }
        }
    }
}
