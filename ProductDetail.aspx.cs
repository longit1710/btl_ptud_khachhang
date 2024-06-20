using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{
    public partial class ProductDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int productId = Convert.ToInt32(Request.QueryString["productId"]);
                LoadProductDetails(productId);
                LoadRelatedProducts(productId); // Ensure related products are loaded on initial load
            }
        }

        private void LoadProductDetails(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT * FROM product WHERE product_id = @ProductId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    ProductName.Text = reader["name"].ToString();
                    ProductPrice.Text = String.Format("{0:C}", reader["price"]);
                    ProductDescription.Text = reader["description"].ToString();
                    ProductImage.ImageUrl = "images/" + reader["image"].ToString();
                }
                conn.Close();
            }
        }

        private void LoadRelatedProducts(int productId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT TOP 4 * FROM product WHERE category_id = (SELECT category_id FROM product WHERE product_id = @ProductId) AND product_id <> @ProductId";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ProductId", productId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataListRelatedProducts.DataSource = reader;
                DataListRelatedProducts.DataBind();
                conn.Close();
            }
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            int productId = Convert.ToInt32(Request.QueryString["productId"]);
            int customerId = Helper.GetUserId();

            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                // Check if the product already exists in the customer's cart with status 'Pending'
                string queryCheck = "SELECT COUNT(*) FROM cart WHERE user_id = @CustomerID AND product_id = @ProductID AND status = 'Pending'";
                SqlCommand cmdCheck = new SqlCommand(queryCheck, conn);
                cmdCheck.Parameters.AddWithValue("@CustomerID", customerId);
                cmdCheck.Parameters.AddWithValue("@ProductID", productId);
                int count = Convert.ToInt32(cmdCheck.ExecuteScalar());

                if (count > 0)
                {
                    // Update quantity and price
                    string queryUpdate = "UPDATE cart SET quantity = quantity + 1 WHERE user_id = @CustomerID AND product_id = @ProductID AND status = 'Pending'";
                    SqlCommand cmdUpdate = new SqlCommand(queryUpdate, conn);
                    cmdUpdate.Parameters.AddWithValue("@CustomerID", customerId);
                    cmdUpdate.Parameters.AddWithValue("@ProductID", productId);

                    // Get product price
                    string queryPrice = "SELECT price FROM product WHERE product_id = @ProductID";
                    SqlCommand cmdPrice = new SqlCommand(queryPrice, conn);
                    cmdPrice.Parameters.AddWithValue("@ProductID", productId);
                    decimal price = Convert.ToDecimal(cmdPrice.ExecuteScalar());

                    cmdUpdate.Parameters.AddWithValue("@Price", price);
                    cmdUpdate.ExecuteNonQuery();
                }
                else
                {
                    // Insert new item into cart
                    string queryInsert = "INSERT INTO [cart] (user_id, product_id, quantity, price, created_date, status) VALUES (@CustomerID, @ProductID, 1, @Price, GETDATE(), 'Pending')";
                    SqlCommand cmdInsert = new SqlCommand(queryInsert, conn);
                    cmdInsert.Parameters.AddWithValue("@CustomerID", customerId);
                    cmdInsert.Parameters.AddWithValue("@ProductID", productId);

                    // Get product price
                    string queryPrice = "SELECT [price] FROM product WHERE product_id = @ProductID";
                    SqlCommand cmdPrice = new SqlCommand(queryPrice, conn);
                    cmdPrice.Parameters.AddWithValue("@ProductID", productId);
                    decimal price = Convert.ToDecimal(cmdPrice.ExecuteScalar());

                    cmdInsert.Parameters.AddWithValue("@Price", price);
                    cmdInsert.ExecuteNonQuery();
                }

                conn.Close();
            }

            // Hiển thị thông báo đã thêm vào giỏ hàng
            string script = "alert('Đã thêm sản phẩm vào giỏ hàng');";
            ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);

            // Reload related products to reflect any changes
            LoadRelatedProducts(productId);
        }

        protected void DataListRelatedProducts_ItemCommand(object source, DataListCommandEventArgs e)
        {
            int productId = Convert.ToInt32(e.CommandArgument);

            if (e.CommandName == "Detail")
            {
                Response.Redirect($"ProductDetail.aspx?productId={productId}");
            }
            else if (e.CommandName == "AddToCart")
            {
                int customerId = Helper.GetUserId();

                string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    // Check if the product already exists in the customer's cart with status 'Pending'
                    string queryCheck = "SELECT COUNT(*) FROM [cart] WHERE user_id = @CustomerID AND product_id = @ProductID AND status = 'Pending'";
                    SqlCommand cmdCheck = new SqlCommand(queryCheck, conn);
                    cmdCheck.Parameters.AddWithValue("@CustomerID", customerId);
                    cmdCheck.Parameters.AddWithValue("@ProductID", productId);
                    int count = Convert.ToInt32(cmdCheck.ExecuteScalar());

                    if (count > 0)
                    {
                        // Update quantity and price
                        string queryUpdate = "UPDATE [cart] SET quantity = quantity + 1 WHERE customer_id = @CustomerID AND product_id = @ProductID AND status = 'Pending'";
                        SqlCommand cmdUpdate = new SqlCommand(queryUpdate, conn);
                        cmdUpdate.Parameters.AddWithValue("@CustomerID", customerId);
                        cmdUpdate.Parameters.AddWithValue("@ProductID", productId);

                        // Get product price
                        string queryPrice = "SELECT price FROM [product] WHERE product_id = @ProductID";
                        SqlCommand cmdPrice = new SqlCommand(queryPrice, conn);
                        cmdPrice.Parameters.AddWithValue("@ProductID", productId);
                        decimal price = Convert.ToDecimal(cmdPrice.ExecuteScalar());

                        cmdUpdate.Parameters.AddWithValue("@Price", price);
                        cmdUpdate.ExecuteNonQuery();
                    }
                    else
                    {
                        // Insert new item into cart
                        string queryInsert = "INSERT INTO [cart] (user_id, product_id, quantity, price, created_date, status) VALUES (@CustomerID, @ProductID, 1, @Price, GETDATE(), 'Pending')";
                        SqlCommand cmdInsert = new SqlCommand(queryInsert, conn);
                        cmdInsert.Parameters.AddWithValue("@CustomerID", customerId);
                        cmdInsert.Parameters.AddWithValue("@ProductID", productId);

                        // Get product price
                        string queryPrice = "SELECT [price] FROM product WHERE product_id = @ProductID";
                        SqlCommand cmdPrice = new SqlCommand(queryPrice, conn);
                        cmdPrice.Parameters.AddWithValue("@ProductID", productId);
                        decimal price = Convert.ToDecimal(cmdPrice.ExecuteScalar());

                        cmdInsert.Parameters.AddWithValue("@Price", price);
                        cmdInsert.ExecuteNonQuery();
                    }

                    conn.Close();
                }

                // Hiển thị thông báo đã thêm vào giỏ hàng
                string script = "alert('Đã thêm sản phẩm vào giỏ hàng');";
                ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", script, true);

                // Reload related products to reflect any changes
                LoadRelatedProducts(productId);
            }
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("TrangChu.aspx");
        }
    }
}
