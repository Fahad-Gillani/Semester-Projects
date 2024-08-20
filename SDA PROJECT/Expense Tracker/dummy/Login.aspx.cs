using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Diagnostics;
using System.Xml.Linq;
using BLL;

namespace dummy
{
    public partial class Login : System.Web.UI.Page
    {
        IDataAccessAdapter dataAccessAdapter;
        BLayer b;
        protected void Page_Load(object sender, EventArgs e)
        {
            dataAccessAdapter = new DataAccessAdapter();
            b = new BLayer(dataAccessAdapter);
        }
        public static string user;
        public static string email;
        protected void Sub_Btn(object sender, EventArgs e)
        {
            try
            {
                string username = us.Value;
                string password = pass.Value;
                
                if (string.IsNullOrEmpty(username))
                    throw new ArgumentException("Username cannot be empty");

                if (string.IsNullOrEmpty(password))
                    throw new ArgumentException("Password cannot be empty");

                AuthenticationService authService = new AuthenticationService();

                bool loginSuccess = authService.AuthenticateUser(username, password);
                if (loginSuccess)
                {
                    user = username;
                    Session["UID"] = authService.Uid(username); // Store userId in session
                    Response.Redirect("Home.aspx"); // Redirect to a home or dashboard page
                }
                else
                {
                    throw new ApplicationException("Invalid Username or Password");
                }
            }
            catch (ArgumentException ex)
            {
                ShowMessage(ex.Message);
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message);
            }
        }


        private void ShowMessage(string message)
        {
            // Escape single quotes in the message to prevent JS errors
            string escapedMessage = message.Replace("'", "\\'");
            string script = $"Swal.fire({{text: '{escapedMessage}', icon: 'info'}});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", script, true);
        }
    }
}

