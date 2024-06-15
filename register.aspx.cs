using System;
using System.Data.SqlClient;
using System.Web.Services;
using System.Web.Hosting;
using System.Web.Services.Protocols;
using System.Text.RegularExpressions;

namespace BTL_PTUD
{
    public partial class register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string firstName = txtFirstName.Text;
            string lastName = txtLastName.Text;
            string email = txtEmail.Text;
            string password = txtPassword.Text;
            string confirmPassword = txtConfirmPassword.Text;
            string address = txtAddress.Text;
            string phoneNumber = txtPhoneNumber.Text;

            // Validate định dạng email
            if (!IsValidEmail(email))
            {
                lblMessage.Text = "Email không hợp lệ.";
                return;
            }

            // Kiểm tra email không được trùng với cơ sở dữ liệu
            if (IsEmailExist(email))
            {
                lblMessage.Text = "Email đã tồn tại trong hệ thống.";
                return;
            }
            // Validate mật khẩu (phải có ít nhất 6 ký tự)
            if (password.Length < 6)
            {
                lblMessage.Text = "Mật khẩu phải có ít nhất 6 ký tự.";
                return;
            }

            // Xác nhận mật khẩu
            if (password != confirmPassword)
            {
                lblMessage.Text = "Mật khẩu xác nhận không khớp.";
                return;
            }

            // Validate FirstName và LastName chỉ chứa chữ cái
            if (!IsAlphaOnly(firstName) || !IsAlphaOnly(lastName))
            {
                lblMessage.Text = "FirstName và LastName chỉ được chứa các chữ cái.";
                return;
            }

            // Validate điện thoại định dạng 10 số
            if (!IsPhoneNumberValid(phoneNumber))
            {
                lblMessage.Text = "Điện thoại không hợp lệ. Yêu cầu định dạng 10 số.";
                return;
            }
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO customer (first_name, last_name,email,password,address,phone_number) VALUES (@FirstName, @LastName, @Email, @Password, @Address, @PhoneNumber)";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@FirstName", firstName);
                cmd.Parameters.AddWithValue("@LastName", lastName);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.Parameters.AddWithValue("@Address", address);
                cmd.Parameters.AddWithValue("@PhoneNumber", phoneNumber);

                try
                {
                    conn.Open();
                    cmd.ExecuteNonQuery();
                    Response.Write("<script>alert('Đăng ký thành công!');window.location='login.aspx';</script>");
                
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Có lỗi xảy ra: " + ex.Message + "');</script>");
                }
            }

        }
        // Hàm validate định dạng email
        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }
        // Hàm kiểm tra email có tồn tại trong cơ sở dữ liệu hay không
        private bool IsEmailExist(string email)
        {
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM customer WHERE email = @Email";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                conn.Open();
                int count = (int)cmd.ExecuteScalar();
                return count > 0;
            }
        }
        // Hàm validate FirstName và LastName chỉ chứa chữ cái
        private bool IsAlphaOnly(string input)
        {
            return Regex.IsMatch(input, @"^[a-zA-Z]+$");
        }

        // Hàm validate điện thoại định dạng 10 số
        private bool IsPhoneNumberValid(string phoneNumber)
        {
            return Regex.IsMatch(phoneNumber, @"^\d{10}$");
        }
    }
}