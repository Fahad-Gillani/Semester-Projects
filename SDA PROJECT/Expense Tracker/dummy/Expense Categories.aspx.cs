using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
namespace dummy
{
    public partial class Expense : System.Web.UI.Page
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
            b= new BLayer(dataAccessAdapter);
            View();
        }
        private void ShowMessage(string message)
        {
            string escapedMessage = message.Replace("'", "\\'");
            string script = $"Swal.fire({{text: '{escapedMessage}', icon: 'info'}});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", script, true);
        }
        protected void Add_EXP_Category(object sender, EventArgs e)
        {
            try
            {
               
                if (string.IsNullOrWhiteSpace(add_ecat.Value))
                {
                    ShowMessage("Fill All Fields");
                    return;
                }

             
                Regex regex = new Regex(@"^[A-Za-z][A-Za-z0-9_]*$");
                if (!regex.IsMatch(add_ecat.Value))
                {
                    ShowMessage("Category name must start with an alphabet and can only contain numbers or underscores afterward.");
                    return;
                }

              
                if (b.ExpenseCategoryExists(add_ecat.Value))
                {
                    ShowMessage("This category already exists.");
                    return;
                }

              
                b.Insert_EXP_Category(add_ecat.Value);

               
                Response.Redirect("Expense Categories.aspx");
            }
            catch (Exception ex)
            {
               
                ShowMessage(ex.Message);
            }
        }


        protected void Del_EXP_Cat(object sender, GridViewDeleteEventArgs e)
        {
            string val = GD.DataKeys[e.RowIndex].Value.ToString();
            b.Delete_EXP_Category(val);
            Response.Redirect("Expense Categories.aspx");
        }
        
        public void View()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            string query = "select * from EXP_Categories";
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

    }
}
 
