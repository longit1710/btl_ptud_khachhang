using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BTL_PTUD
{
    public static class Helper
    {
        public static int GetCustomerId()
        {
            if (HttpContext.Current.Session["CustomerId"] != null)
            {
                return (int)HttpContext.Current.Session["CustomerId"];
            }
            return -1; // Hoặc một giá trị mặc định nào đó nếu không tìm thấy ID khách hàng
        }
    }
}