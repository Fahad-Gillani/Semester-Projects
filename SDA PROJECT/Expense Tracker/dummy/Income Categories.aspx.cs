using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using System.Diagnostics;
using System.Text.RegularExpressions;
namespace dummy
{
    public partial class Income_Categories : System.Web.UI.Page
    {
        IDataAccessAdapter dataAccessAdapter;
        BLayer b;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            dataAccessAdapter = new DataAccessAdapter();
            b = new BLayer(dataAccessAdapter);
            GD.DataSource = b.ViewIncomeCategory();
            GD.DataBind();
        }
         
        protected void Add_INC_Category(object sender, EventArgs e)
        {
            try
            {
             
                if (string.IsNullOrWhiteSpace(add_icat.Value))
                {
                    ShowMessage("Fill All Fields");
                    return;
                }

                
                Regex regex = new Regex(@"^[A-Za-z][A-Za-z0-9_]*$");
                if (!regex.IsMatch(add_icat.Value))
                {
                    ShowMessage("Category name must start with an alphabet and can only contain numbers or underscores afterward.");
                    return;
                }

               
                if (b.INC_CategoryExists(add_icat.Value))
                {
                    ShowMessage("This category already exists.");
                    return;
                }

              
                b.Insert_INC_Category(add_icat.Value);

               
                Response.Redirect("Income Categories.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message);
            }
        }
        protected void Del_INC_Cat(object sender, GridViewDeleteEventArgs e)
        {
            string val = GD.DataKeys[e.RowIndex].Value.ToString();
            b.Delete_INC_Category(val);
            Response.Redirect("Income Categories.aspx");
        }

        public void View()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            string query = "select * from INC_Categories";
            using (conn)
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    GD.DataSource = cmd.ExecuteReader();
                    GD.DataBind();
                }
            }
        }

        protected void Logout(Object sender, EventArgs e)
        {
            if (Session["UID"] != null)
            {
                AuthenticationService authService = new AuthenticationService();
                string userId = Session["UID"].ToString();
                authService.LogoutUser(userId);
                Session["UID"] = null;
                Response.Redirect("Login.aspx");
            }
        }
        private void ShowMessage(string message)
        {
            string escapedMessage = message.Replace("'", "\\'");
            string script = $"Swal.fire({{text: '{escapedMessage}', icon: 'info'}});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", script, true);
        }
    }
}
