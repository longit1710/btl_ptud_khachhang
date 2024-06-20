using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{
    public partial class PaymentConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int customerId = Helper.GetUserId();
                string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string deleteCartItemsQuery = @"
                    UPDATE oi SET status = 'Paid' FROM [order_item] oi INNER JOIN [order] o ON oi.order_id = o.order_id WHERE user_id = @user_id";
                    SqlCommand cmd = new SqlCommand(deleteCartItemsQuery, conn);
                    cmd.Parameters.AddWithValue("@user_id", customerId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
                ClearCart(customerId);
            }
        }
        protected void ClearCart(int customerId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string deleteCartItemsQuery = @"
                    UPDATE [cart] SET status = 'Paid'
                    WHERE user_id = @CustomerID AND status = 'Pending'";
                SqlCommand cmd = new SqlCommand(deleteCartItemsQuery, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }
    }
}