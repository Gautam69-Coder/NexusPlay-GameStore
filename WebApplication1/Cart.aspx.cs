using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class Cart : Page
    {
        SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
        SqlCommand co = new SqlCommand();
        SqlDataReader ds;

        public string CartBadgeCssClass { get; set; } = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (cn.State == ConnectionState.Closed)
                cn.Open();
            co.Connection = cn;

            var currentUser = AuthHelper.GetCurrentUser(Request);
            if (currentUser == null)
            {
                Response.Redirect("Signin.aspx?returnUrl=Cart.aspx");
                return;
            }

            litNavUsername.Text = currentUser.Username;

            if (!IsPostBack)
            {
                BindCart(currentUser.UserId);
            }
        }

        private void BindCart(int userId)
        {
            if (cn.State == ConnectionState.Closed)
                cn.Open();
            co.Connection = cn;

            co.CommandText = "select id, user_id, game_id, game_code, title, license_type, price, platform, image_url, quantity from [dbo].[cart] where user_id=" + userId + " order by id asc";
            ds = co.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(ds);
            ds.Close();

            if (dt.Rows.Count == 0)
            {
                pnlActiveCart.Visible = false;
                pnlEmptyCart.Visible = true;
                litHeaderCount.Text = "0";
                litNavCartCount.Text = "0";
                CartBadgeCssClass = "";
                return;
            }

            pnlActiveCart.Visible = true;
            pnlEmptyCart.Visible = false;

            int totalQty = 0;
            decimal subtotal = 0m;

            foreach (DataRow row in dt.Rows)
            {
                int qty = Convert.ToInt32(row["quantity"]);
                decimal price = Convert.ToDecimal(row["price"]);
                totalQty += qty;
                subtotal += (price * qty);
            }

            litHeaderCount.Text = totalQty.ToString();
            litNavCartCount.Text = totalQty.ToString();
            CartBadgeCssClass = totalQty > 0 ? "has-items" : "";
            litSubtotal.Text = "$" + subtotal.ToString("F2");

            decimal discount = 0m;
            if (ViewState["PromoApplied"] != null && (bool)ViewState["PromoApplied"])
            {
                discount = Math.Round(subtotal * 0.10m, 2);
                pnlDiscountRow.Visible = true;
                litDiscount.Text = "-$" + discount.ToString("F2");
            }
            else
            {
                pnlDiscountRow.Visible = false;
            }

            decimal grandTotal = Math.Max(0m, subtotal - discount);
            litGrandTotal.Text = "$" + grandTotal.ToString("F2");

            rptCartItems.DataSource = dt;
            rptCartItems.DataBind();
        }

        protected void rptCartItems_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            var currentUser = AuthHelper.GetCurrentUser(Request);
            if (currentUser == null) return;

            int userId = currentUser.UserId;
            int cartId = Convert.ToInt32(e.CommandArgument);

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                if (string.Equals(e.CommandName, "del", StringComparison.OrdinalIgnoreCase))
                {
                    co.CommandText = "delete from [dbo].[cart] where id=" + cartId + " and user_id=" + userId;
                    co.ExecuteNonQuery();
                }
                else if (string.Equals(e.CommandName, "inc", StringComparison.OrdinalIgnoreCase))
                {
                    co.CommandText = "update [dbo].[cart] set quantity = quantity + 1 where id=" + cartId + " and user_id=" + userId;
                    co.ExecuteNonQuery();
                }
                else if (string.Equals(e.CommandName, "dec", StringComparison.OrdinalIgnoreCase))
                {
                    co.CommandText = "select quantity from [dbo].[cart] where id=" + cartId + " and user_id=" + userId;
                    ds = co.ExecuteReader();
                    int currentQty = 1;
                    if (ds.Read())
                    {
                        currentQty = Convert.ToInt32(ds["quantity"]);
                    }
                    ds.Close();

                    if (currentQty <= 1)
                    {
                        co.CommandText = "delete from [dbo].[cart] where id=" + cartId + " and user_id=" + userId;
                        co.ExecuteNonQuery();
                    }
                    else
                    {
                        co.CommandText = "update [dbo].[cart] set quantity = quantity - 1 where id=" + cartId + " and user_id=" + userId;
                        co.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error modifying cart item: " + ex.Message);
            }

            BindCart(userId);
        }

        protected void btnClearCart_Click(object sender, EventArgs e)
        {
            var currentUser = AuthHelper.GetCurrentUser(Request);
            if (currentUser == null) return;

            int userId = currentUser.UserId;

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = "delete from [dbo].[cart] where user_id=" + userId;
                co.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error clearing cart: " + ex.Message);
            }

            BindCart(userId);
        }

        protected void btnApplyPromo_Click(object sender, EventArgs e)
        {
            var currentUser = AuthHelper.GetCurrentUser(Request);
            int userId = currentUser != null ? currentUser.UserId : 0;

            string code = txtPromo.Text?.Trim().ToUpperInvariant();
            if (code == "NEXUS10")
            {
                ViewState["PromoApplied"] = true;
                lblPromoFeedback.Text = "Success: 10% discount applied to your cart!";
                lblPromoFeedback.ForeColor = System.Drawing.ColorTranslator.FromHtml("#10b981");
                lblPromoFeedback.Visible = true;
            }
            else
            {
                ViewState["PromoApplied"] = false;
                lblPromoFeedback.Text = "Invalid promo code. Try 'NEXUS10'";
                lblPromoFeedback.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ef4444");
                lblPromoFeedback.Visible = true;
            }

            if (userId > 0)
            {
                BindCart(userId);
            }
        }
    }
}
