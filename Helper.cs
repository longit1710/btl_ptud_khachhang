using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_PTUD
{
    public static class Helper
    {
        public static int GetUserId()
        {
            if (HttpContext.Current.Session["user_id"] != null)
            {
                return (int)HttpContext.Current.Session["user_id"];
            }
            return -1; // Hoặc một giá trị mặc định nào đó nếu không tìm thấy ID khách hàng
        }
    }
}