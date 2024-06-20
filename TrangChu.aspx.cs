using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;

namespace BTL_PTUD
{
    public partial class TrangChu : System.Web.UI.Page
    {
        private int currentPage = 1;
        private const int PageSize = 8;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                currentPage = 1;
                ViewState["CurrentPage"] = currentPage;
                LoadProductsPaged(currentPage);

                LoadCategories();
            }
        }

        private void LoadProductsPaged(int page)
        {
            int offset = (page - 1) * PageSize;
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = $"SELECT * FROM (SELECT ROW_NUMBER() OVER (ORDER BY product_id) AS RowNum, * FROM product) AS Products WHERE RowNum > {offset} AND RowNum <= {offset + PageSize}";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataListProducts.DataSource = reader;
                DataListProducts.DataBind();
                conn.Close();
            }

            UpdatePaginationButtons(page);
        }

        private void UpdatePaginationButtons(int page)
        {
            int totalProducts = GetTotalProductsCount();
            int totalPages = (int)Math.Ceiling((double)totalProducts / PageSize);

            btnPrevious.Enabled = page > 1;
            btnNext.Enabled = page < totalPages;
            lblCurrentPage.Text = page.ToString();
        }

        private int GetTotalProductsCount()
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

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            currentPage = (int)ViewState["CurrentPage"];
            if (currentPage > 1)
            {
                currentPage--;
                ViewState["CurrentPage"] = currentPage;
                LoadProductsPaged(currentPage);
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            currentPage = (int)ViewState["CurrentPage"];
            currentPage++;
            ViewState["CurrentPage"] = currentPage;
            LoadProductsPaged(currentPage);
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchKeyword = txtSearch.Text.Trim();
            string query = $"SELECT * FROM product WHERE name LIKE '%{searchKeyword}%'";

            LoadProducts(query);
        }

        protected void btnFilterPrice_Click(object sender, EventArgs e)
        {
            string priceRange = ddlPriceRange.SelectedValue;
            string query = "";

            if (priceRange == "100000-300000")
            {
                query = "SELECT * FROM product WHERE price BETWEEN 100000 AND 300000";
            }
            else if (priceRange == "300000-500000")
            {
                query = "SELECT * FROM product WHERE price BETWEEN 300000 AND 500000";
            }
            else if (priceRange == "500000-")
            {
                query = "SELECT * FROM product WHERE price > 500000";
            }

            if (!string.IsNullOrEmpty(query))
            {
                LoadProducts(query);
            }
        }

        private void LoadProducts(string query)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                DataListProducts.DataSource = reader;
                DataListProducts.DataBind();
                conn.Close();
            }
        }

        protected void btnShowBestSellers_Click(object sender, EventArgs e)
        {
            string query = "SELECT TOP 5 * FROM product ORDER BY salecount DESC";
            LoadProducts(query);
        }

        protected void btnShowNewProducts_Click(object sender, EventArgs e)
        {
            string query = "SELECT TOP 5 * FROM product ORDER BY date_added DESC";
            LoadProducts(query);
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            currentPage = 1;
            ViewState["CurrentPage"] = currentPage;
            LoadProductsPaged(currentPage);
        }

        protected void btnViewCart_Click(object sender, EventArgs e)
        {
            Response.Redirect("Cart.aspx");
        }

        protected void btnViewOrder_Click(object sender, EventArgs e)
        {
            Response.Redirect("Order.aspx");
        }

        protected void DataListProducts_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "Detail")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                Response.Redirect($"ProductDetail.aspx?productId={productId}");
            }
            else if (e.CommandName == "AddToCart")
            {
                int productId = Convert.ToInt32(e.CommandArgument);
                int customerId = Helper.GetUserId();
                if (customerId == -1)
                {
                    string alt = "alert('Vui lòng đăng nhập để thêm sản phẩm vào giỏ hàng');";
                    ScriptManager.RegisterStartupScript(this, GetType(), "ServerControlScript", alt, true);
                    Response.Redirect("login.aspx");
                    return;
                }

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
                        // Update quantity
                        string queryUpdate = "UPDATE [cart] SET quantity = quantity + 1 WHERE user_id = @CustomerID AND product_id = @ProductID AND status = 'Pending'";
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
                        string queryPrice = "SELECT price FROM [product] WHERE product_id = @ProductID";
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
                Response.Redirect("Cart.aspx");
            }
        }

        private void LoadCategories()
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            string query = "SELECT * FROM category";

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                rptCategories.DataSource = reader;
                rptCategories.DataBind();
                conn.Close();
            }
        }
        protected void rptCategories_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "SelectCategory")
            {
                int categoryId = Convert.ToInt32(e.CommandArgument);
                string query = $"SELECT * FROM [product] WHERE category_id = {categoryId}";

                LoadProducts(query);
            }
        }

        protected void DataListProducts_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
