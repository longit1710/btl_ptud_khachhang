using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;

namespace BTL_PTUD
{
    public partial class QL_Product : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtSearch.Text = "";
                SqlDataSource1.FilterExpression = "";
                SqlDataSource1.FilterParameters.Clear();
            }
        }

        public void cmdSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text;
            if (!string.IsNullOrEmpty(searchTerm))
            {
                SqlDataSource1.FilterExpression = "name LIKE '%{0}%'";
                SqlDataSource1.FilterParameters.Clear();
                SqlDataSource1.FilterParameters.Add(new Parameter("0", TypeCode.String, searchTerm));
            }
            else
            {
                //txtSearch.Text = "";
                SqlDataSource1.FilterExpression = "";
                SqlDataSource1.FilterParameters.Clear();
            }
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            FileUpload fileUpload = (FileUpload)row.FindControl("FileUpload1");
            HiddenField hiddenImageField = (HiddenField)row.FindControl("HiddenImageField");

            if (fileUpload.HasFile)
            {
                String path = Server.MapPath("~/images/");
                fileUpload.PostedFile.SaveAs(path + fileUpload.FileName);
                SqlDataSource1.UpdateParameters["image"].DefaultValue = fileUpload.FileName;
            }
            else
            {
                SqlDataSource1.UpdateParameters["image"].DefaultValue = hiddenImageField.Value;
            }
        }
    }
}