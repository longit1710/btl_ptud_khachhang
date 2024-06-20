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
            int userID = Helper.GetUserId(); // Assume this retrieves the customer ID

            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT o.order_date AS OrderDate, oi.status AS Status,
                           oi.order_item_id AS OrderItemID, oi.product_id AS ProductID, oi.quantity AS Quantity, oi.price AS Price,
                           p.name AS ProductName, p.image AS Image, SUM(oi.quantity * oi.price) as TotalAmount
                    FROM [order] o
                    INNER JOIN [order_item] oi ON o.order_id = oi.order_id
                    INNER JOIN [product] p ON oi.product_id = p.product_id
                    WHERE o.user_id = @userID
                    GROUP BY o.order_date, oi.status, oi.order_item_id, oi.product_id, oi.quantity, oi.price, p.name, p.image
                    ORDER BY o.order_date DESC";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userID", userID);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataSet ds = new DataSet();
                adapter.Fill(ds);

                rptOrders.DataSource = ds;
                rptOrders.DataBind();

                conn.Close();
            }
        }

        private int GetUserId()
        {
            // Implement a method to retrieve the currently logged-in customer's ID
            return 1; // Placeholder
        }

        protected void rptOrders_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {

        }

        protected void rptOrders_ItemCommand1(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {

        }
        private DataTable GetOrderItems(int orderID)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT oi.order_item_id AS OrderItemID, oi.product_id AS ProductID, oi.quantity AS Quantity, oi.price AS Price,
                           p.name AS ProductName, p.image AS Image
                    FROM [order_item] oi
                    INNER JOIN [product] p ON oi.product_id = p.product_id
                    WHERE oi.order_id = @orderID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@orderID", orderID);

                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                adapter.Fill(dt);

                return dt;
            }
        }
    }
}
