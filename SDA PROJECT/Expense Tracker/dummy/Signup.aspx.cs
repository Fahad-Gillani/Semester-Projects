using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;

namespace dummy
{
    public partial class Signup : System.Web.UI.Page
    {
        IDataAccessAdapter dataAccessAdapter;
        BLayer b;
        protected void Page_Load(object sender, EventArgs e)
        {
            dataAccessAdapter=new DataAccessAdapter();
            b=new BLayer(dataAccessAdapter);
        }
        protected void Sub_btn(object sender, EventArgs e)
        {
            try
            {
                
                if (string.IsNullOrWhiteSpace(uname.Value))
                {
                    throw new Exception("Username cannot be blank.");
                }

                Regex usernameRegex = new Regex(@"^[A-Za-z][A-Za-z0-9_]*$");
                if (!usernameRegex.IsMatch(uname.Value))
                {
                    throw new Exception("Username must start with an alphabet and can only contain numbers or underscores afterward.");
                }

                if (string.IsNullOrWhiteSpace(dob.Value))
                {
                    throw new Exception("Date of Birth cannot be blank.");
                }

        
                if (string.IsNullOrWhiteSpace(pass.Value))
                {
                    throw new Exception("Password cannot be blank.");
                }

       
                if (string.IsNullOrWhiteSpace(email.Value))
                {
                    throw new Exception("Email cannot be blank.");
                }

                Regex emailRegex = new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                if (!emailRegex.IsMatch(email.Value))
                {
                    throw new Exception("Invalid email format.");
                }

           
                if (IsUsernameExists(uname.Value))
                {
                    throw new Exception("Username already exists. Please choose a different username.");
                }


                b.Signup(uname.Value, DateTime.Parse(dob.Value), int.Parse(pass.Value), email.Value);
                Response.Redirect("Login.aspx");
            }
            catch (Exception ex)
            {
                ShowMessage("Invalid Entry: " + ex.Message);
            }
        }


        private bool IsUsernameExists(string username)
        {
            bool exists = false;
            string connectionString = "Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users WHERE UName = @Username", conn);
                    cmd.Parameters.AddWithValue("@Username", username);

                    int count = (int)cmd.ExecuteScalar();
                    exists = count > 0;
                    System.Diagnostics.Debug.WriteLine($"Username check: {username}, Count: {count}, Exists: {exists}");
                }
                catch (Exception ex)
                {
                    ShowMessage("Error checking username existence: " + ex.Message);
                }
            }

            return exists;
        }

        private void ShowMessage(string message)
        {
            string escapedMessage = message.Replace("'", "\\'");
            string script = $"Swal.fire({{text: '{escapedMessage}', icon: 'info'}});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", script, true);
        }



    }
}
