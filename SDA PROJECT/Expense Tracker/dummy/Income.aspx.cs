using BLL;
using Microsoft.Ajax.Utilities;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Drawing;
using System.Data;
using System.Text.RegularExpressions;


namespace dummy
{
    public partial class Income : System.Web.UI.Page
    {
        IDataAccessAdapter dataAccessAdapter;
        BLayer b;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            dataAccessAdapter =new DataAccessAdapter();
            b = new BLayer(dataAccessAdapter);
             
            if (!IsPostBack)
            {
                LoadCategories();
                View();
            }
        }
        protected void NewTR(object sender, EventArgs e)
        {
            Response.Redirect("Transaction1.aspx");
        }
        protected void Del_INC(object sender, GridViewDeleteEventArgs e)
        {
            Label id = GD.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
            b.DeleteIncome(Convert.ToInt32(id.Text));
            Response.Redirect("Income.aspx");
        }

        protected void Cancel_Up_INC(object sender, GridViewCancelEditEventArgs e)
        {
            GD.EditIndex = -1;
            View();
            
        }

        protected void Edit_Income(object sender, GridViewEditEventArgs e)
        {
            GD.EditIndex = e.NewEditIndex;
            View();
        }
        protected void Up_Income(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                Label id = GD.Rows[e.RowIndex].FindControl("lbl_ID") as Label;
                TextBox name = GD.Rows[e.RowIndex].FindControl("txt_Name") as TextBox;
                TextBox amount = GD.Rows[e.RowIndex].FindControl("txt_Amount") as TextBox;
                TextBox desc = GD.Rows[e.RowIndex].FindControl("txt_Desc") as TextBox;

                if (string.IsNullOrWhiteSpace(name.Text))
                {
                    throw new Exception("Name cannot be blank.");
                }

                Regex regex = new Regex(@"^[A-Za-z][A-Za-z0-9_]*$");
                if (!regex.IsMatch(name.Text))
                {
                    throw new Exception("Name must start with an alphabet and can only contain numbers or underscores afterward.");
                }

                if (string.IsNullOrWhiteSpace(amount.Text))
                {
                    throw new Exception("Amount cannot be blank.");
                }

                if (string.IsNullOrWhiteSpace(desc.Text))
                {
                    throw new Exception("Description cannot be blank.");
                }

                int amountValue;
                if (!int.TryParse(amount.Text, out amountValue) || amountValue < 0)
                {
                    throw new Exception("Amount cannot be negative or invalid.");
                }

                SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
                conn.Open();
                SqlCommand cmd = new SqlCommand("Update INC set Name=@Name, Amount=@Amount, Description=@Description where id=@Id", conn);
                cmd.Parameters.AddWithValue("@Name", name.Text);
                cmd.Parameters.AddWithValue("@Amount", amountValue);
                cmd.Parameters.AddWithValue("@Description", desc.Text);
                cmd.Parameters.AddWithValue("@Id", Convert.ToInt32(id.Text));

                cmd.ExecuteNonQuery();
                conn.Close();

                GD.EditIndex = -1;
                View();
            }
            catch (Exception ex)
            {
                ShowMessage(ex.Message);
            }

        }
        public void View()
        {
            GD.DataSource = b.ViewIncome(Login.user);
            GD.DataBind();
        }
        protected void Btn_CSV(object sender, EventArgs e)
        {
            Response.Clear();
            Response.Buffer = true;
            Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.csv");
            Response.Charset = "";
            Response.ContentType = "text/csv";
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < GD.Columns.Count && i < 5; i++)
            {
                sb.Append(GD.Columns[i].HeaderText + ",");
            }
            sb.AppendLine();
            for (int i = 0; i < GD.Rows.Count; i++)
            {
                for (int j = 0; j < GD.Columns.Count && j < 5; j++)
                {
                    string cellText = GetCellText(GD.Rows[i].Cells[j]);
                    cellText = cellText.Replace(",", ";"); 
                    sb.Append(cellText + ",");
                }
                sb.AppendLine();
            }
            Response.Output.Write(sb.ToString());
            Response.Flush();
            Response.End();
        }

        private string GetCellText(TableCell cell)
        {
            foreach (Control control in cell.Controls)
            {
                if (control is Label)
                {
                    return ((Label)control).Text;
                }
                else if (control is TextBox)
                {
                    return ((TextBox)control).Text;
                }
            }
            return cell.Text.Trim();
        }


        protected void Btn_PDF(object sender, EventArgs e)
        {
            using (MemoryStream ms = new MemoryStream())
            {
                Document document = new Document(PageSize.A4);

                try
                {
                    PdfWriter.GetInstance(document, ms);
                    document.Open();
                    PdfPTable table = new PdfPTable(5);
                    int maxColumns = Math.Min(GD.Columns.Count, 5);
                    for (int i = 0; i < maxColumns; i++)
                    {
                        PdfPCell pdfCell = new PdfPCell(new Phrase(GD.Columns[i].HeaderText));
                        table.AddCell(pdfCell);
                    }
                    foreach (GridViewRow gridViewRow in GD.Rows)
                    {
                        for (int i = 0; i < maxColumns; i++)
                        {
                            string cellText = GetCellText(gridViewRow.Cells[i]);
                            PdfPCell pdfCell = new PdfPCell(new Phrase(cellText));
                            table.AddCell(pdfCell);
                        }
                    }
                    document.Add(table);
                }
                finally
                {
                    document.Close();
                }
                Response.Clear();
                Response.ContentType = "application/pdf";
                Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.pdf");
                Response.OutputStream.Write(ms.GetBuffer(), 0, ms.GetBuffer().Length);
                Response.OutputStream.Flush();
                Response.OutputStream.Close();
                Response.End();
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
        protected void Filter(Object sender, EventArgs e)
        {
            string connectionString = "Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True";
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    DataTable dtInc = new DataTable();
                    string queryInc = "SELECT * FROM INC WHERE Category = @Category";
                    using (SqlCommand cmd = new SqlCommand(queryInc, conn))
                    {
                        cmd.Parameters.AddWithValue("@Category", icategory.Value);
                        using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                        {
                            adapter.Fill(dtInc);
                        }
                    }
                    if (dtInc.Rows.Count == 0)
                    {
                        ShowMessage("No records found for the selected category.");
                    }
                    else
                    {
                        GD.DataSource = dtInc;
                        GD.DataBind();
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

        protected void Clear(Object sender, EventArgs e)
        {
            Response.Redirect("Income.aspx");
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
                    string queryInc = "SELECT Category FROM INC_Categories";
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
    }
}

