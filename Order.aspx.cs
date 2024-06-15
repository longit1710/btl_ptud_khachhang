using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace BTL_PTUD
{
    public partial class Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindOrders();
            }
        }

        private void BindOrders()
        {
            int customerId = GetCustomerId(); // Assume this retrieves the customer ID

            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT o.order_id AS OrderID, o.order_date AS OrderDate, o.total_amount AS TotalAmount, o.status AS Status,
                           oi.order_item_id AS OrderItemID, oi.product_id AS ProductID, oi.quantity AS Quantity, oi.price AS Price,
                           p.name AS ProductName, p.image AS Image
                    FROM [order] o
                    INNER JOIN order_item oi ON o.order_id = oi.order_id
                    INNER JOIN product p ON oi.product_id = p.product_id
                    WHERE o.customer_id = @CustomerID
                    ORDER BY o.order_date DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                rptOrders.DataSource = ds;
                rptOrders.DataBind();

                conn.Close();
            }
        }

        private int GetCustomerId()
        {
            // Implement a method to retrieve the currently logged-in customer's ID
            return 1; // Placeholder
        }
    }
}
