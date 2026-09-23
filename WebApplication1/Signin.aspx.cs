using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Signin : Page
    {
        SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
        SqlCommand co = new SqlCommand();
        SqlDataReader ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (cn.State == ConnectionState.Closed)
                cn.Open();
            co.Connection = cn;

            if (string.Equals(Request.QueryString["action"], "logout", StringComparison.OrdinalIgnoreCase))
            {
                AuthHelper.ClearAuthCookie(Response);
                Response.Redirect("Signin.aspx");
                return;
            }

            if (AuthHelper.GetCurrentUser(Request) != null)
            {
                Response.Redirect("Home.aspx");
                return;
            }

            if (!IsPostBack)
            {
                lblError.Visible = false;
            }
        }

        protected void btnSignIn_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string identifier = txtIdentifier.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(identifier) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Please enter both your email/gamertag and password.";
                lblError.Visible = true;
                return;
            }

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = "select top 1 id, username, email from [dbo].[user] where (email='" + identifier.Replace("'", "''") + "' or username='" + identifier.Replace("'", "''") + "') and password='" + password.Replace("'", "''") + "'";
                ds = co.ExecuteReader();

                if (ds.Read())
                {
                    int userId = Convert.ToInt32(ds["id"]);
                    string username = ds["username"].ToString().Trim();
                    string email = ds["email"].ToString().Trim();
                    ds.Close();

                    // Set authentication cookie (no session)
                    AuthHelper.SetAuthCookie(Response, userId, username, email);

                    string returnUrl = Request.QueryString["returnUrl"];
                    if (!string.IsNullOrEmpty(returnUrl))
                    {
                        Response.Redirect(returnUrl);
                        return;
                    }

                    Response.Redirect("Home.aspx");
                    return;
                }
                else
                {
                    ds.Close();
                    lblError.Text = "Invalid email/gamertag or password.";
                    lblError.Visible = true;
                }
            }
            catch (Exception ex)
            {
                lblError.Text = "Database connection error: " + ex.Message;
                lblError.Visible = true;
            }
        }
    }
}
