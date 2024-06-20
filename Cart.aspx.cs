using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{
    public partial class Cart : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            int userID = Helper.GetUserId();
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
            SELECT c.cart_id, c.product_id, p.name, p.image, c.quantity, c.price
            FROM [cart] c
            JOIN [product] p ON c.product_id = p.product_id
            WHERE c.user_id = @userID AND c.status = 'Pending'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@userID", userID);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                rptCart.DataSource = reader;
                rptCart.DataBind();
                reader.Close(); // Đóng DataReader sau khi sử dụng xong

                query = @"
            SELECT SUM(price * quantity)
            FROM [cart]
            WHERE user_id = @userID AND status = 'Pending'
            GROUP BY user_id";
                using (SqlCommand cmdd = new SqlCommand(query, conn))
                {
                    cmdd.Parameters.AddWithValue("@userID", userID);
                    var totalPrice = cmdd.ExecuteScalar();
                    lblTotalPrice.Text = ((decimal?)totalPrice ?? 0).ToString("#,##0.00") + " ₫";
                }


                conn.Close(); // Đóng SqlConnection sau khi sử dụng xong
            }
        }


        protected void rptCart_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int cartId = Convert.ToInt32(e.CommandArgument);
            int quantity = 0;
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                if (e.CommandName == "Increase")
                {
                    quantity = GetQuantity(cartId) + 1;
                }
                else if (e.CommandName == "Decrease")
                {
                    quantity = GetQuantity(cartId) - 1;
                    if (quantity < 1)
                    {
                        // Xóa sản phẩm khỏi giỏ hàng nếu số lượng là 0
                        string deleteQuery = "DELETE FROM [cart] WHERE cart_id = @CartID";
                        SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                        deleteCmd.Parameters.AddWithValue("@CartID", cartId);

                        conn.Open();
                        deleteCmd.ExecuteNonQuery();
                        conn.Close();

                        LoadCart();
                        return;
                    }
                }

                string query = "UPDATE [cart] SET quantity = @Quantity WHERE cart_id = @CartID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@CartID", cartId);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            LoadCart();
        }

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            TextBox txtQuantity = (TextBox)sender;
            RepeaterItem item = (RepeaterItem)txtQuantity.NamingContainer;
            int cartId = Convert.ToInt32(((HiddenField)item.FindControl("hfCartId")).Value);
            int productId = Convert.ToInt32(((HiddenField)item.FindControl("hfProductId")).Value); // Lấy product_id từ HiddenField
            int quantity = Convert.ToInt32(txtQuantity.Text);

            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                if (quantity < 1)
                {
                    // Xóa sản phẩm khỏi giỏ hàng nếu số lượng là 0
                    string deleteQuery = "DELETE FROM [cart] WHERE cart_id = @CartID";
                    SqlCommand deleteCmd = new SqlCommand(deleteQuery, conn);
                    deleteCmd.Parameters.AddWithValue("@CartID", cartId);

                    conn.Open();
                    deleteCmd.ExecuteNonQuery();
                    conn.Close();
                }
                else
                {
                    string query = "UPDATE [cart] SET quantity = @Quantity WHERE cart_id = @CartID";
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Quantity", quantity);
                    cmd.Parameters.AddWithValue("@CartID", cartId);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Payment.aspx");
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            // Chuyển hướng về trang chủ
            Response.Redirect("TrangChu.aspx");
        }


        private int GetQuantity(int cartId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT quantity FROM [cart] WHERE cart_id = @CartID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CartID", cartId);

                conn.Open();
                return (int)cmd.ExecuteScalar();
            }
        }
    }
}
