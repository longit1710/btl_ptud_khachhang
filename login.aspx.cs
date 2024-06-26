﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{   
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnok_Click(object sender, EventArgs e)
        {
            string email, mk;
            email = Request.Form["txtemail"];
            mk = Request.Form["txtmk"];
            int userID = GetUserId(email, mk);
            if (IsValidUser(email, mk))
            {
                // Đăng nhập thành công
                Session["user_id"] = userID;
                Response.Redirect("TrangChu.aspx");
            }
            else
            {
                // Đăng nhập thất bại
                //Response.Write("<script>alert('Email hoặc mật khẩu không đúng');</script>");
            }
        }
        private bool IsValidUser(string email, string password)
        {
            // Lấy chuỗi kết nối từ Web.config
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(1) FROM [user] WHERE email = @Email AND password = @Password";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                try
                {
                    conn.Open();
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    // Nếu count > 0, thông tin đăng nhập hợp lệ
                    return count > 0;
                }
                catch (Exception ex)
                {
                    // Xử lý lỗi nếu có
                    Response.Write("<script>alert('Có lỗi xảy ra: " + ex.Message + "');</script>");
                    return false;
                }
            }
        }
        private int GetUserId(string email, string password)
        {
            // Lấy chuỗi kết nối từ Web.config
            string connStr = ConfigurationManager.ConnectionStrings["MyConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT user_id FROM [user] WHERE email = @Email AND password = @Password";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Password", password);

                    conn.Open();
                    var result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        return Convert.ToInt32(result);
                    }
            }
            return -1; // Trả về -1 nếu thông tin đăng nhập không hợp lệ
        }
        protected void btndky_Click(object sender, EventArgs e)
        {
            Response.Redirect("register.aspx");
        }

    }
}