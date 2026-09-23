using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;

namespace WebApplication1
{
    public partial class Transactions : Page
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
                Response.Redirect("Signin.aspx?returnUrl=Transactions.aspx");
                return;
            }

            litNavUsername.Text = currentUser.Username;

            if (!IsPostBack)
            {
                LoadTransactions(currentUser.UserId);
                LoadCartCount(currentUser.UserId);
            }
        }

        private void LoadCartCount(int userId)
        {
            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;
                co.CommandText = "select isnull(sum(quantity), 0) from [dbo].[cart] where user_id=" + userId;
                int count = Convert.ToInt32(co.ExecuteScalar());
                litNavCartCount.Text = count.ToString();
                if (count > 0) CartBadgeCssClass = "has-items";
            }
            catch
            {
                litNavCartCount.Text = "0";
            }
        }

        private void LoadTransactions(int userId)
        {
            try
            {
                if (cn.State == ConnectionState.Closed)
                    cn.Open();
                co.Connection = cn;

                co.CommandText = @"
                    select 
                        t.id, 
                        t.transaction_id, 
                        t.order_number, 
                        t.amount, 
                        t.payment_method, 
                        t.payment_status, 
                        t.card_last4, 
                        t.created_at,
                        o.target_platform,
                        (select count(1) from [dbo].[order_items] oi where oi.order_id = t.order_id) as item_count
                    from [dbo].[transaction_history] t
                    inner join [dbo].[orders] o on t.order_id = o.id
                    where t.user_id = " + userId + @"
                    order by t.id desc";

                ds = co.ExecuteReader();
                DataTable dt = new DataTable();
                dt.Load(ds);
                ds.Close();

                if (dt.Rows.Count == 0)
                {
                    pnlNoTransactions.Visible = true;
                    pnlTransactionsList.Visible = false;
                    litTxnCount.Text = "0";
                }
                else
                {
                    pnlNoTransactions.Visible = false;
                    pnlTransactionsList.Visible = true;
                    litTxnCount.Text = dt.Rows.Count.ToString();
                    rptTransactions.DataSource = dt;
                    rptTransactions.DataBind();
                }
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Error loading transactions: " + ex.Message);
            }
        }
    }
}
