using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using BLL;
using DotNet.Highcharts.Helpers;
using System.Text.RegularExpressions;
namespace dummy
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UID"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            Inc();
            Exp();
            Bal();
            LoadLineChart();
            DonutChart();
            LoadIncomeExpenseChart();
        }

        public void Inc()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            DataTable dt = new DataTable();
            using (conn)
            {
                string q = "Select sum(amount) from INC where IncUSer='" + Login.user + "'";
                SqlDataAdapter ad = new SqlDataAdapter(q, conn);
                ad.Fill(dt);
                if (dt.Rows[0][0] != DBNull.Value)
                {
                    inc.InnerText = "Rs " + Convert.ToInt32(dt.Rows[0][0]).ToString("N0");
                }
                else
                {
                    inc.InnerText = "Rs 0";
                }
            }
        }

        public void Exp()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            DataTable dt = new DataTable();
            using (conn)
            {
                string q = "Select sum(amount) from EXPEN where ExpUSer='" + Login.user + "'";
                SqlDataAdapter ad = new SqlDataAdapter(q, conn);
                ad.Fill(dt);
                if (dt.Rows[0][0] != DBNull.Value)
                {
                    exp.InnerText = "Rs " + Convert.ToInt32(dt.Rows[0][0]).ToString("N0");
                }
                else
                {
                    exp.InnerText = "Rs 0";
                }
            }
        }

        public void Bal()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            DataTable dtIncome = new DataTable();
            DataTable dtExpense = new DataTable();
            using (conn)
            {
                string incomeQuery = "SELECT SUM(Amount) FROM INC WHERE IncUser='" + Login.user + "'";
                string expenseQuery = "SELECT SUM(Amount) FROM EXPEN WHERE ExpUser='" + Login.user + "'";

                SqlDataAdapter incomeAdapter = new SqlDataAdapter(incomeQuery, conn);
                SqlDataAdapter expenseAdapter = new SqlDataAdapter(expenseQuery, conn);

                incomeAdapter.Fill(dtIncome);
                expenseAdapter.Fill(dtExpense);

                int totalIncome = dtIncome.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dtIncome.Rows[0][0]) : 0;
                int totalExpense = dtExpense.Rows[0][0] != DBNull.Value ? Convert.ToInt32(dtExpense.Rows[0][0]) : 0;

                decimal balance = totalIncome - totalExpense;
                bal.InnerText = "Rs " + balance.ToString("N0");
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

        public string lineData;
        public string donutData;
        public string incomeData;
        public string expenseData;
        public void LoadLineChart()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            DataTable dt = new DataTable();
            using (conn)
            {
                string q = "SELECT SUM(e.Amount) as [Total Expense], MONTH(e.Date) as Month FROM EXPEN e WHERE e.ExpUser='" + Login.user + "' GROUP BY MONTH(e.Date)";
                SqlDataAdapter ad = new SqlDataAdapter(q, conn);
                ad.Fill(dt);
                lineData = "[";
                foreach (DataRow row in dt.Rows)
                {
                    lineData += "[" + row["Month"] + "," + row["Total Expense"] + "],";
                }
                lineData = lineData.Remove(lineData.Length - 1) + ']';
            }
        }
        public void DonutChart()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            DataTable dt = new DataTable();
            using (conn)
            {
                string q = "SELECT c.Category, SUM(e.Amount) as TotalExpense FROM EXPEN e JOIN EXP_Categories c ON e.Category = c.Category WHERE e.ExpUser ='" + Login.user + "'  GROUP BY c.Category";
                SqlDataAdapter ad = new SqlDataAdapter(q, conn);
                ad.Fill(dt);
                donutData = "[";
                foreach (DataRow row in dt.Rows)
                {
                    donutData += "{ name: '" + row["Category"] + "', y: " + row["TotalExpense"] + " },";
                }
                donutData = donutData.Remove(donutData.Length - 1) + "]";
            }

        }
        public void LoadIncomeExpenseChart()
        {
            SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            DataTable dt = new DataTable();
            using (conn)
            {
                string q = @"
            SELECT 
                MONTH(Date) AS Month,
                SUM(CASE WHEN Type = 'Income' THEN Amount ELSE 0 END) AS TotalIncome,
                SUM(CASE WHEN Type = 'Expense' THEN Amount ELSE 0 END) AS TotalExpense
            FROM ( SELECT Date, Amount, 'Expense' AS Type FROM EXPEN WHERE ExpUser = '"+Login.user+"' UNION ALL SELECT Date, Amount, 'Income' AS Type FROM INC WHERE IncUser ='"+Login.user+"') AS Combined GROUP BY MONTH(Date) ORDER BY MONTH(Date)";
                SqlDataAdapter ad = new SqlDataAdapter(q, conn);
                ad.Fill(dt);

                incomeData = "[";
                expenseData = "[";
                foreach (DataRow row in dt.Rows)
                {
                    incomeData += row["TotalIncome"] + ",";
                    expenseData += row["TotalExpense"] + ",";
                }
                incomeData = incomeData.TrimEnd(',') + "]";
                expenseData = expenseData.TrimEnd(',') + "]";
            }
        }
    }
}




