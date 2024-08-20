using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.Net.Mail;
using System.Data.SqlClient;
using System.Diagnostics;
using static System.Net.WebRequestMethods;
namespace dummy
{
    public partial class Forgot : System.Web.UI.Page
    {

        SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
       protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        public static string email;
        protected void Gen_Btn(object sender, EventArgs e)
        {
            try
            {
                using (conn)
                {
                    conn.Open();
                    string query = "SELECT UID FROM us WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", us.Value.ToString());
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            conn.Close();
                            Random rand = new Random();
                            int r = rand.Next(1000, 9999);
                            string otp = r.ToString();
                            conn.Open();
                            string updateQuery = "UPDATE us SET OTP = @OTP WHERE Email = @Email";
                            using (SqlCommand cmdUpdate = new SqlCommand(updateQuery, conn))
                            {
                                cmdUpdate.Parameters.AddWithValue("@OTP", otp);
                                cmdUpdate.Parameters.AddWithValue("@Email", us.Value.ToString());
                                cmdUpdate.ExecuteNonQuery();
                            }
                            conn.Close();
                            MailMessage mail = new MailMessage();
                            mail.To.Add(us.Value.ToString());
                            mail.From = new MailAddress("fahadgillani08@gmail.com");
                            mail.Subject = "Reset Password";
                            string emailBody = "<h1>Hello User,</h1>";
                            emailBody += "Note down the following OTP.<br>";
                            emailBody += $"<p> OTP: {otp}</p>";
                            emailBody += "Thank you.....";
                            mail.Body = emailBody;
                            mail.IsBodyHtml = true;

                            SmtpClient smtp = new SmtpClient();
                            smtp.Port = 587;
                            smtp.EnableSsl = true;
                            smtp.UseDefaultCredentials = false;
                            smtp.Host = "smtp.gmail.com";
                            smtp.Credentials = new NetworkCredential("fahadgillani08@gmail.com", "yxcn febv hohk zeiq");
                            smtp.Send(mail);
                            
                            ShowMessage("OTP sent successfully.");
                            us.Disabled= true;
                            otptxt.Visible= true;
                            sb_btn.Visible= true;
                        }
                        else
                        {
                            ShowMessage("Email does not exist. Please provide a valid email address.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred: " + ex.Message);
            }
        }

        protected void Sub_Btn(object sender, EventArgs e)
        {
            string email = us.Value.ToString();
            string enteredOtp = otptxt.Value.ToString();

            try
            {
                using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
                {
                    conn.Open();
                    string query = "SELECT OTP FROM us WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        SqlDataReader reader = cmd.ExecuteReader();

                        if (reader.Read())
                        {
                            string storedOtp = reader["OTP"].ToString();
                            if (enteredOtp == storedOtp)
                            {
                                ShowMessage("OTP is valid.");
                                pass.Visible = true;
                                otptxt.Visible = false;
                                us.Visible = false;
                                otp_btn.Visible = false;
                                sb_btn.Visible = false;
                                up_btn.Visible = true;
                            }
                            else
                            {
                                ShowMessage("Invalid OTP.");
                            }
                        }
                        else
                        {
                            ShowMessage("Email does not exist or is invalid.");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred: " + ex.Message);
            }
        }
        protected void Upd_Btn(object sender, EventArgs e)
        {
            string email = us.Value.ToString();
            string p = pass.Value.ToString();

            try
            {
                if(string.IsNullOrEmpty(p))
                {
                    ShowMessage("Field cannot be Empty");
                    return;
                }
                using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
                {
                    conn.Open();
                    string query = "update us set UPass='"+p+"' WHERE Email = @Email";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.ExecuteNonQuery();
                        
                    }
                }
                ShowMessage("Password Updated Successfully");
                Response.Redirect("Login.aspx");

            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred: " + ex.Message);
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
