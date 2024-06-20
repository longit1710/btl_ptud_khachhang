using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{
    public partial class thongKe : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Assume these are the counts you want to display
                int totalProducts = GetProductCount();
                int totalCarts = GetCartCount();
                int totalOrders = GetOrderCount();
                int totalUsers = GetUserCount();

                // Assign values to the HTML elements
                productCount.Text = totalProducts.ToString();
                cartCount.Text = totalCarts.ToString();
                orderCount.Text = totalOrders.ToString();
                userCount.Text = totalUsers.ToString();

                BindTop5Products();
                BindTop5ASCProducts();
            }
        }
        private int GetProductCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM product";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();
                return count;
            }
        }

        private int GetCartCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM cart";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();
                return count;
            }
        }

        private int GetOrderCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM [order_item] oi INNER JOIN [order] o ON oi.order_id = o.order_id";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();
                return count;
            }
        }

        private int GetUserCount()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT COUNT(*) FROM [user]";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                conn.Close();
                return count;
            }
        }

        protected void txtYear_TextChanged(object sender, EventArgs e)
        {
            SqlDataSource1.SelectParameters["Year"].DefaultValue = txtYear.Text;

            GridView1.DataBind();
        }
        private void BindTop5Products()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            string query = @"SELECT TOP 5 p.name AS productName, SUM(oi.quantity) AS TotalQuantity
                             FROM order_item oi
                             INNER JOIN product p ON oi.product_id = p.product_id
                             GROUP BY p.name
                             ORDER BY TotalQuantity DESC";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                conn.Close();

                rptTopProducts.DataSource = dt;
                rptTopProducts.DataBind();
            }
        }

        private void BindTop5ASCProducts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            string query = @"SELECT TOP 5 p.name AS Name, SUM(oi.quantity) AS Total
                             FROM order_item oi
                             INNER JOIN product p ON oi.product_id = p.product_id
                             GROUP BY p.name
                             ORDER BY Total ASC";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);
                conn.Close();

                Repeater1.DataSource = dt;
                Repeater1.DataBind();
            }
        }
    }
}