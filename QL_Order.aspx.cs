using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BTL_PTUD
{
    public partial class QL_Order : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                SqlDataSource1.FilterExpression = "";
                SqlDataSource1.FilterParameters.Clear();
                txtSearch.Text = "";
            }
        }

        protected void cmdSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text;
            if (!string.IsNullOrEmpty(searchTerm))
            {
                // Thiết lập bộ lọc khi người dùng nhấn nút tìm kiếm
                SqlDataSource1.FilterExpression = "user_id={0}";
                //SqlDataSource1.FilterExpression = "user_id={0} OR status LIKE '%{0}%'";
                SqlDataSource1.FilterParameters.Clear();
                SqlDataSource1.FilterParameters.Add(new Parameter("0", TypeCode.String, searchTerm));
            }
            else
            {
                // Nếu giá trị tìm kiếm trống, xóa bỏ bộ lọc
                SqlDataSource1.FilterExpression = "";
                SqlDataSource1.FilterParameters.Clear();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }
    }
}