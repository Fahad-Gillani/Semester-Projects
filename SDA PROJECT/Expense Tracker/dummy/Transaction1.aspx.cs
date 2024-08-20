using System;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI;
using BLL;
using System.Net;
using System.Net.Mail;
using static System.Net.WebRequestMethods;
using System.Diagnostics;
namespace dummy
{
    public partial class Transaction1 : System.Web.UI.Page
    {
        IDataAccessAdapter dataAccessAdapter;
        BLayer b;
        public String EM;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            dataAccessAdapter = new DataAccessAdapter();
            b= new BLayer(dataAccessAdapter);
            if (!IsPostBack)
            {
                try
                {
                    LoadCategories();
                }
                catch (Exception ex)
                {
                    ShowMessage("An error occurred while loading categories: " + ex.Message);
                }
            }
        }
        public void ClearIncomeFields()
        {
            iname.Value = "";
            iamount.Value = "";
            idate.Value = "";
            idescription.Value = "";
        }
        public void ClearExpenseFields()
        {
            ename.Value = "";
            eamount.Value = "";
            edate.Value = "";
            edescription.Value = "";
        }
        public string Email(string user)
        {
            string em = string.Empty;

            using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
            {
                conn.Open();
                string query = "SELECT Email FROM us WHERE UName = @user";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@user", user);
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            em = reader.GetString(0);
                        }
                    }
                }
            }

            return em;
        }
        protected void IButton(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(iname.Value) || string.IsNullOrWhiteSpace(iamount.Value) ||
                    string.IsNullOrWhiteSpace(idate.Value) || string.IsNullOrWhiteSpace(idescription.Value))
                {
                    ShowMessage("All fields are required.");
                    return;
                }

                // Regular expression to validate name
                Regex regex = new Regex(@"^[A-Za-z][A-Za-z0-9_]*$");
                if (!regex.IsMatch(iname.Value))
                {
                    ShowMessage("Name must start with an alphabet and can only contain numbers or underscores afterward.");
                    return;
                }

                int amount;
                if (!int.TryParse(iamount.Value, out amount))
                {
                    ShowMessage("Amount must be a valid number.");
                    return;
                }

                if (amount < 0)
                {
                    ShowMessage("Amount cannot be negative.");
                    return;
                }

                b.InsertIncome(iname.Value, amount, icategory.Value, Login.user, DateTime.Parse(idate.Value), idescription.Value);
                ShowMessage("Income inserted successfully.");
                ClearIncomeFields();
                MailMessage mail = new MailMessage();
                Debug.WriteLine(Email(Login.user));
                mail.To.Add(Email(Login.user));
                mail.From = new MailAddress("fahadgillani08@gmail.com");
                mail.Subject = "Income Transaction";
                string emailBody = $"<h1>Dear User {Login.user},</h1>";
                emailBody += $"Amount {amount} has been added Successfully to your account.<br>";
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
            }
            catch (FormatException ex)
            {
                ShowMessage("Invalid input: " + ex.Message);
            }
            catch (SqlException ex)
            {
                ShowMessage("A database error occurred: " + ex.Message);
            }
            catch (Exception ex)
            {
                ShowMessage("An unexpected error occurred: " + ex.Message);
            }
        }

        protected void EButton(object sender, EventArgs e)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(ename.Value) || string.IsNullOrWhiteSpace(eamount.Value) ||
                    string.IsNullOrWhiteSpace(edate.Value) || string.IsNullOrWhiteSpace(edescription.Value))
                {
                    ShowMessage("All fields are required.");
                    return;
                }

                // Regular expression to validate name
                Regex regex = new Regex(@"^[A-Za-z][A-Za-z0-9_]*$");
                if (!regex.IsMatch(ename.Value))
                {
                    ShowMessage("Name must start with an alphabet and can only contain numbers or underscores afterward.");
                    return;
                }

                int amount;
                if (!int.TryParse(eamount.Value, out amount))
                {
                    ShowMessage("Amount must be a valid number.");
                    return;
                }

                if (amount < 0)
                {
                    ShowMessage("Amount cannot be negative.");
                    return;
                }

                b.InsertExpense(ename.Value, amount, ecategory.Value, Login.user, DateTime.Parse(edate.Value), edescription.Value);
                ShowMessage("Expense inserted successfully.");
                ClearExpenseFields();
                MailMessage mail = new MailMessage();
                Debug.WriteLine(Email(Login.user));
                mail.To.Add(Email(Login.user));
                mail.From = new MailAddress("fahadgillani08@gmail.com");
                mail.Subject = "Expense Transaction";
                string emailBody = $"<h1>Dear User {Login.user},</h1>";
                emailBody += $"Amount {amount} has been deducted Successfully from your account.<br>";
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
            }
            catch (FormatException ex)
            {
                ShowMessage("Invalid input: " + ex.Message);
            }
            catch (SqlException ex)
            {
                ShowMessage("A database error occurred: " + ex.Message);
            }
            catch (Exception ex)
            {
                ShowMessage("An unexpected error occurred: " + ex.Message);
            }
        }

        protected void LoadCategories()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            try
            {
                using (conn)
                {
                    conn.Open();
                    DataTable dtInc = new DataTable();
                    DataTable dtExp = new DataTable();

                    string queryInc = "SELECT Category FROM INC_Categories";
                    string queryExp = "SELECT Category FROM EXP_Categories";

                    using (SqlCommand cmd = new SqlCommand(queryInc, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dtInc);
                        }
                        icategory.DataTextField = "Category";
                        icategory.DataValueField = "Category";
                        icategory.DataSource = dtInc;
                        icategory.DataBind();
                    }

                    using (SqlCommand cmd = new SqlCommand(queryExp, conn))
                    {
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dtExp);
                        }
                        ecategory.DataTextField = "Category";
                        ecategory.DataValueField = "Category";
                        ecategory.DataSource = dtExp;
                        ecategory.DataBind();
                    }
                }
            }
            catch (SqlException ex)
            {
                ShowMessage("A database error occurred while loading categories: " + ex.Message);
            }
            catch (Exception ex)
            {
                ShowMessage("An unexpected error occurred while loading categories: " + ex.Message);
            }
        }

        private void ShowMessage(string message)
        {
            
            string escapedMessage = message.Replace("'", "\\'");
            string script = $"Swal.fire({{text: '{escapedMessage}', icon: 'info'}});";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "MessageBox", script, true);
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
