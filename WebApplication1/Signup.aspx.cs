using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Signup : Page
    {
        SqlConnection cn = new SqlConnection(@"Data Source=.\SQLEXPRESS01;Initial Catalog=GameStore;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=True;");
        SqlCommand co = new SqlCommand();
        SqlDataReader ds;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (cn.State == ConnectionState.Closed)
                cn.Open();
            co.Connection = cn;

            if (AuthHelper.GetCurrentUser(Request) != null)
            {
                Response.Redirect("Home.aspx");
                return;
            }
        }

        protected void btnSignUp_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string gamertag = txtGamertag.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text;

            if (string.IsNullOrEmpty(gamertag) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.Text = "All fields are required.";
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff4d4d");
                lblMessage.Visible = true;
                return;
            }

            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                // Check if account already exists using ExecuteReader
                co.CommandText = "select id from [dbo].[user] where email='" + email.Replace("'", "''") + "' or username='" + gamertag.Replace("'", "''") + "'";
                ds = co.ExecuteReader();
                bool exists = ds.Read();
                ds.Close();

                if (exists)
                {
                    lblMessage.Text = "An account with this GamerTag or Email already exists.";
                    lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff4d4d");
                    lblMessage.Visible = true;
                    return;
                }

                // Insert new user into database and get generated id
                co.CommandText = "insert into [dbo].[user] (username, email, password) output inserted.id values ('" + gamertag.Replace("'", "''") + "', '" + email.Replace("'", "''") + "', '" + password.Replace("'", "''") + "')";
                int newUserId = Convert.ToInt32(co.ExecuteScalar());

                // Set authentication cookie (no session) and navigate to store home
                AuthHelper.SetAuthCookie(Response, newUserId, gamertag, email);
                Response.Redirect("Home.aspx");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error during registration: " + ex.Message;
                lblMessage.ForeColor = System.Drawing.ColorTranslator.FromHtml("#ff4d4d");
                lblMessage.Visible = true;
            }
        }
    }
}
