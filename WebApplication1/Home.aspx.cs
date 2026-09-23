using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace WebApplication1
{
    public class CartAjaxResponse
    {
        public bool success { get; set; }
        public int totalCount { get; set; }
        public string message { get; set; }
        public string redirect { get; set; }
    }

    public partial class Home : Page
    {
        SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
        SqlCommand co = new SqlCommand();
        SqlDataReader ds;

        public string SelectedCategory { get; set; } = "all";
        public string SearchTerm { get; set; } = string.Empty;
        public string CartBadgeCssClass { get; set; } = string.Empty;
        private List<GameItem> _allGames = new List<GameItem>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (cn.State == ConnectionState.Closed)
                cn.Open();
            co.Connection = cn;

            var currentUser = AuthHelper.GetCurrentUser(Request);

            // Fallback for query string ?action=add&id=xxx&type=xxx
            if (string.Equals(Request.QueryString["action"], "add", StringComparison.OrdinalIgnoreCase))
            {
                string addGameId = Request.QueryString["id"];
                string addType = Request.QueryString["type"] ?? "Buy";

                if (currentUser == null)
                {
                    Response.Redirect("Signin.aspx?returnUrl=" + Server.UrlEncode(Request.RawUrl));
                    return;
                }

                AddToCartDb(currentUser.UserId, addGameId, addType);
                Response.Redirect("Home.aspx#featuredGames");
                return;
            }

            string cat = Request.QueryString["cat"];
            if (!string.IsNullOrEmpty(cat))
            {
                SelectedCategory = cat.Trim().ToLowerInvariant();
            }

            string q = Request.QueryString["q"];
            if (!string.IsNullOrEmpty(q))
            {
                SearchTerm = q.Trim();
                if (!IsPostBack && txtSearch != null)
                {
                    txtSearch.Text = SearchTerm;
                }
            }

            LoadGamesFromDatabase();

            if (!IsPostBack)
            {
                BindGames();
                UpdateActiveTabs();
            }

            // Display gamer profile & cart count
            if (currentUser != null)
            {
                if (litUsername != null) litUsername.Text = currentUser.Username;
                if (litHeroUser != null) litHeroUser.Text = currentUser.Username;
                if (lnkSignOut != null) lnkSignOut.Visible = true;

                int cartCount = GetCartItemCount(currentUser.UserId);
                if (litCartCount != null) litCartCount.Text = cartCount.ToString();
                if (cartCount > 0) CartBadgeCssClass = "has-items";
            }
            else
            {
                if (litUsername != null) litUsername.Text = "Gamer";
                if (litHeroUser != null) litHeroUser.Text = "Gamer";
                if (lnkSignOut != null) lnkSignOut.Visible = false;
                if (litCartCount != null) litCartCount.Text = "0";
            }
        }

        private void LoadGamesFromDatabase()
        {
            _allGames = new List<GameItem>();
            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = "select id, game_code, title, subtitle, category, category_label, score, image_url, buy_price, original_price, discount_badge, rent_price, rent_duration, platforms from [dbo].[games] where is_active=1 order by id asc";
                ds = co.ExecuteReader();

                while (ds.Read())
                {
                    _allGames.Add(new GameItem
                    {
                        Id = ds["game_code"].ToString(),
                        Title = ds["title"].ToString(),
                        Subtitle = ds["subtitle"] != DBNull.Value ? ds["subtitle"].ToString() : "",
                        Category = ds["category"].ToString(),
                        CategoryLabel = ds["category_label"] != DBNull.Value ? ds["category_label"].ToString() : "",
                        Score = ds["score"] != DBNull.Value ? ds["score"].ToString() : "9.0",
                        ImageUrl = ds["image_url"].ToString(),
                        BuyPrice = Convert.ToDecimal(ds["buy_price"]),
                        OriginalPrice = ds["original_price"] != DBNull.Value ? (decimal?)Convert.ToDecimal(ds["original_price"]) : null,
                        DiscountBadge = ds["discount_badge"] != DBNull.Value ? ds["discount_badge"].ToString() : null,
                        RentPrice = Convert.ToDecimal(ds["rent_price"]),
                        RentDuration = ds["rent_duration"] != DBNull.Value ? ds["rent_duration"].ToString() : "7 Days",
                        Platforms = ds["platforms"] != DBNull.Value ? ds["platforms"].ToString() : "PC"
                    });
                }
                ds.Close();
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error reading games: " + ex.Message);
            }
        }

        private void BindGames()
        {
            IEnumerable<GameItem> filtered = _allGames;

            if (!string.IsNullOrEmpty(SelectedCategory) && !SelectedCategory.Equals("all", StringComparison.OrdinalIgnoreCase))
            {
                filtered = filtered.Where(g => g.Category.Equals(SelectedCategory, StringComparison.OrdinalIgnoreCase));
            }

            string search = txtSearch != null ? txtSearch.Text.Trim() : SearchTerm;
            if (!string.IsNullOrEmpty(search))
            {
                filtered = filtered.Where(g =>
                    (g.Title != null && g.Title.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (g.CategoryLabel != null && g.CategoryLabel.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0) ||
                    (g.Platforms != null && g.Platforms.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0));
            }

            rptGames.DataSource = filtered.ToList();
            rptGames.DataBind();
        }

        private void UpdateActiveTabs()
        {
            tabAll.CssClass = "filter-tab" + (SelectedCategory == "all" ? " active" : "");
            tabAction.CssClass = "filter-tab" + (SelectedCategory == "action" ? " active" : "");
            tabFantasy.CssClass = "filter-tab" + (SelectedCategory == "fantasy" ? " active" : "");
            tabMech.CssClass = "filter-tab" + (SelectedCategory == "mech" ? " active" : "");
            tabRacing.CssClass = "filter-tab" + (SelectedCategory == "racing" ? " active" : "");
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindGames();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            BindGames();
        }

        private static int GetCartItemCount(int userId)
        {
            try
            {
                SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
                SqlCommand co = new SqlCommand();
                cn.Open();
                co.Connection = cn;

                co.CommandText = "select isnull(sum(quantity), 0) from [dbo].[cart] where user_id=" + userId;
                int count = Convert.ToInt32(co.ExecuteScalar());
                cn.Close();
                return count;
            }
            catch
            {
                return 0;
            }
        }

        private static bool AddToCartDb(int userId, string gameCode, string licenseType)
        {
            try
            {
                SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
                SqlCommand co = new SqlCommand();
                SqlDataReader ds;
                cn.Open();
                co.Connection = cn;

                // 1. Fetch game details
                co.CommandText = "select top 1 id, title, buy_price, rent_price, platforms, image_url from [dbo].[games] where game_code='" + gameCode.Replace("'", "''") + "' and is_active=1";
                ds = co.ExecuteReader();

                if (!ds.Read())
                {
                    ds.Close();
                    cn.Close();
                    return false;
                }

                int gameId = Convert.ToInt32(ds["id"]);
                string title = ds["title"].ToString();
                string platforms = ds["platforms"].ToString();
                string imageUrl = ds["image_url"].ToString();
                bool isRent = string.Equals(licenseType, "Rent", StringComparison.OrdinalIgnoreCase);
                decimal price = isRent ? Convert.ToDecimal(ds["rent_price"]) : Convert.ToDecimal(ds["buy_price"]);
                ds.Close();

                // 2. Check if item already exists in user's cart
                co.CommandText = "select top 1 id from [dbo].[cart] where user_id=" + userId + " and game_code='" + gameCode.Replace("'", "''") + "' and license_type='" + licenseType.Replace("'", "''") + "'";
                object existing = co.ExecuteScalar();

                if (existing != null && existing != DBNull.Value)
                {
                    co.CommandText = "update [dbo].[cart] set quantity = quantity + 1 where id=" + existing.ToString();
                    co.ExecuteNonQuery();
                }
                else
                {
                    co.CommandText = "insert into [dbo].[cart] (user_id, game_id, game_code, title, license_type, price, platform, image_url, quantity) values (" + userId + ", " + gameId + ", '" + gameCode.Replace("'", "''") + "', '" + title.Replace("'", "''") + "', '" + licenseType.Replace("'", "''") + "', " + price + ", '" + platforms.Replace("'", "''") + "', '" + imageUrl.Replace("'", "''") + "', 1)";
                    co.ExecuteNonQuery();
                }

                cn.Close();
                return true;
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error adding to cart: " + ex.Message);
                return false;
            }
        }

        [System.Web.Services.WebMethod]
        public static CartAjaxResponse AddToCartAjax(string gameCode, string licenseType)
        {
            var currentUser = AuthHelper.GetCurrentUser(System.Web.HttpContext.Current?.Request);
            if (currentUser == null)
            {
                return new CartAjaxResponse
                {
                    success = false,
                    message = "Please sign in to add games to your cart.",
                    redirect = "Signin.aspx?returnUrl=Home.aspx"
                };
            }

            int userId = currentUser.UserId;
            bool added = AddToCartDb(userId, gameCode, licenseType);

            if (!added)
            {
                return new CartAjaxResponse
                {
                    success = false,
                    message = "Could not add game to cart. Please check database catalog."
                };
            }

            int newTotal = GetCartItemCount(userId);
            string typeLabel = string.Equals(licenseType, "Rent", StringComparison.OrdinalIgnoreCase) ? "Rental Pass" : "Permanent Key";

            return new CartAjaxResponse
            {
                success = true,
                totalCount = newTotal,
                message = $"Game ({typeLabel}) added to your cart!"
            };
        }
    }
}
