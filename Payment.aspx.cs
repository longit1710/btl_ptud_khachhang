using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{
    public partial class Payment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        protected void LoadCart()
        {
            int customerId = GetCustomerId();
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = @"
                    SELECT c.product_id, p.name, c.quantity, c.price
                    FROM cart c
                    JOIN product p ON c.product_id = p.product_id
                    WHERE c.customer_id = @CustomerID AND c.status = 'Pending'";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                rptCart.DataSource = reader;
                rptCart.DataBind();
                reader.Close();

                query = @"
                    SELECT SUM(c.quantity * c.price) AS TotalAmount
                    FROM cart c
                    WHERE c.customer_id = @CustomerID AND c.status = 'Pending'";
                cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);
                lblTotalAmount.Text = ((decimal?)cmd.ExecuteScalar() ?? 0).ToString("C");

                conn.Close();
            }
        }

        protected void btnPay_Click(object sender, EventArgs e)
        {
            int customerId = GetCustomerId();
            string paymentMethod = ddlPaymentMethod.SelectedValue;

            // Tạo đơn hàng từ giỏ hàng và lưu vào CSDL
            CreateOrder(customerId, paymentMethod);

            // Xóa các sản phẩm trong giỏ hàng sau khi đã tạo đơn hàng
            ClearCart(customerId);

            // Chuyển hướng người dùng đến trang xác nhận thanh toán
            Response.Redirect("PaymentConfirmation.aspx");
        }

        protected void CreateOrder(int customerId, string paymentMethod)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Tạo mới đơn hàng
                string insertOrderQuery = @"
                    INSERT INTO [order] (customer_id, order_date, payment_method)
                    VALUES (@CustomerID, GETDATE(), @PaymentMethod);
                    SELECT SCOPE_IDENTITY();";
                SqlCommand cmd = new SqlCommand(insertOrderQuery, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);
                cmd.Parameters.AddWithValue("@PaymentMethod", paymentMethod);

                conn.Open();
                int orderId = Convert.ToInt32(cmd.ExecuteScalar());

                // Thêm từng sản phẩm trong giỏ hàng vào bảng order_item
                string insertOrderItemQuery = @"
                    INSERT INTO order_item (order_id, product_id, quantity, price)
                    SELECT @OrderID, product_id, quantity, price
                    FROM cart
                    WHERE customer_id = @CustomerID AND status = 'Pending'";
                SqlCommand cmdItems = new SqlCommand(insertOrderItemQuery, conn);
                cmdItems.Parameters.AddWithValue("@OrderID", orderId);
                cmdItems.Parameters.AddWithValue("@CustomerID", customerId);
                cmdItems.ExecuteNonQuery();

                conn.Close();
            }
        }

        protected void ClearCart(int customerId)
        {
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string deleteCartItemsQuery = @"
                    DELETE FROM cart
                    WHERE customer_id = @CustomerID AND status = 'Pending'";
                SqlCommand cmd = new SqlCommand(deleteCartItemsQuery, conn);
                cmd.Parameters.AddWithValue("@CustomerID", customerId);

                conn.Open();
                cmd.ExecuteNonQuery();
                conn.Close();
            }
        }

        private int GetCustomerId()
        {
            // Thay thế phương thức này bằng cách lấy ID của khách hàng đã đăng nhập hoặc theo định danh phù hợp
            return 1; // Giả định trả về ID của khách hàng
        }
        protected void rptCart_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Lấy dữ liệu từ DataItem
                DataRowView drv = (DataRowView)e.Item.DataItem;

                // Ví dụ: Gán dữ liệu cho một control trong ItemTemplate
                Label lblProductName = (Label)e.Item.FindControl("lblProductName");
                if (lblProductName != null)
                {
                    lblProductName.Text = drv["name"].ToString();
                }

                // Các xử lý khác tương tự
            }
        }

    }
}
