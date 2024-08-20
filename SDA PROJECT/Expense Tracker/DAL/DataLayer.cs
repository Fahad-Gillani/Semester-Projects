using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.SqlClient;
using System.Data;
using System.Net.Configuration;
using System.Security.AccessControl;
using System.Diagnostics;
using System.Security.Cryptography;
using System.Xml.Linq;
namespace DAL
{

    public class UserSessionManager
    {
        private static UserSessionManager _instance;
        private static readonly object _lock = new object();
        private static bool _isAnyUserLoggedIn = false; // Global state to track if any user is logged in

        private Dictionary<string, string> _activeSessions;

        private UserSessionManager()
        {
            _activeSessions = new Dictionary<string, string>();
        }

        public static UserSessionManager Instance
        {
            get
            {
                lock (_lock)
                {
                    if (_instance == null)
                    {
                        _instance = new UserSessionManager();
                    }
                    return _instance;
                }
            }
        }

        public bool IsUserLoggedIn(string userId)
        {
            return _activeSessions.ContainsKey(userId);
        }

        public bool IsAnyUserLoggedIn()
        {
            return _isAnyUserLoggedIn;
        }

        public void LoginUser(string userId, string sessionId)
        {
            lock (_lock)
            {
                if (_isAnyUserLoggedIn)
                {
                    throw new Exception("Another user is already logged in");
                }

                if (!IsUserLoggedIn(userId))
                {
                    _activeSessions[userId] = sessionId;
                    _isAnyUserLoggedIn = true; // Set the global state to true
                }
                else
                {
                    throw new Exception("User already logged in");
                }
            }
        }

        public void LogoutUser(string userId)
        {
            lock (_lock)
            {
                if (IsUserLoggedIn(userId))
                {
                    _activeSessions.Remove(userId);
                    _isAnyUserLoggedIn = false; // Set the global state to false
                }
            }
        }

        public string GetUserSession(string userId)
        {
            return _activeSessions.TryGetValue(userId, out var sessionId) ? sessionId : null;
        }
    }

    public class DataLayer
    {

        public SqlConnection conn;
        public DataTable dt;
        public DataLayer()
        {
            conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            dt = new DataTable();
        }

        public void Signup(string name, DateTime dob, int pass, string email)
        {
            string query = "INSERT INTO us (uname,udob ,upass,email) values (@Name, @dob,@pass,@email)";
            using (conn)
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@dob", dob);
                    cmd.Parameters.AddWithValue("@pass", pass);
                    cmd.Parameters.AddWithValue("@email", email);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void InsertIncome(string name, int amount, string cat, string incuser, DateTime date, string desc)
        {
            string query = "INSERT INTO INC (name, amount, Category, IncUser, date, description) VALUES (@Name, @Amount, @Cat, @IncUser, @Date, @Description)";
            using (conn)
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@Cat", cat);
                        cmd.Parameters.AddWithValue("@IncUser", incuser);
                        cmd.Parameters.AddWithValue("@Date", date);
                        cmd.Parameters.AddWithValue("@Description", desc);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex)
                {

                    throw new ApplicationException("A database error occurred: " + ex.Message);
                }
                catch (Exception ex)
                {

                    throw new ApplicationException("An unexpected error occurred: " + ex.Message);
                }
            }
        }

        public void InsertExpense(string name, int amount, string cat, string expuser, DateTime date, string desc)
        {
            string query = "INSERT INTO EXPEN (name, amount, Category, ExpUser, date, description) VALUES (@Name, @Amount, @Cat, @ExpUser, @Date, @Description)";
            using (conn)
            {
                try
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@Cat", cat);
                        cmd.Parameters.AddWithValue("@ExpUser", expuser);
                        cmd.Parameters.AddWithValue("@Date", date);
                        cmd.Parameters.AddWithValue("@Description", desc);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }
                catch (SqlException ex)
                {

                    throw new ApplicationException("A database error occurred: " + ex.Message);
                }
                catch (Exception ex)
                {
                    throw new ApplicationException("An unexpected error occurred: " + ex.Message);
                }
            }
        }

       
        public object ViewIncome(string incuser)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("Select * from INC where IncUser='" + incuser + "' order by id DESC", conn);
            adapter.Fill(dt);
            return dt;
        }

        public object ViewExpense(string expuser)
        {
            SqlDataAdapter adapter = new SqlDataAdapter("Select * from EXPEN where ExpUser='" + expuser + "' order by id DESC", conn);
            adapter.Fill(dt);
            return dt;
        }

        public void DeleteExpense(int id)
        {
            using (conn)
            {
                string query = "Delete from EXPEN where id=@id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

        }
        public void DeleteIncome(int id)
        {
            using (conn)
            {
                string query = "Delete from INC where id=@id";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

        }


        public void Insert_INC_Category(string cat)
        {
            string query = "insert into INC_Categories (Category) values (@cat)";
            using (conn)
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@Cat", cat);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw new ApplicationException("An unexpected error occurred: " + ex.Message);
                    }
                }
            }
        }

        public void Insert_EXP_Category(string cat)
        {
            string query = "insert into EXP_Categories (Category) values (@cat)";
            using (conn)
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    try
                    {
                        cmd.Parameters.AddWithValue("@Cat", cat);
                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw new ApplicationException("An unexpected error occurred: " + ex.Message);
                    }
                }
            }
        }
        public object ViewIncomeCategory()
        {
            SqlConnection con = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            SqlDataAdapter adp = new SqlDataAdapter("Select * from INC_Categories", con);
            adp.Fill(dt);
            return dt;
        }

        public object ViewExpenseCategory()
        {
            SqlConnection con = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True");
            SqlDataAdapter adp = new SqlDataAdapter("Select * from EXP_Categories", con);
            adp.Fill(dt);
            return dt;
        }

        public void Up_INC_Category(int ct, string cat)
        {
            using (conn)
            {
                string query = "update INC_Categories set Category = @cat where id=@ct";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ct", ct);
                    Debug.WriteLine("DB " + ct);
                    cmd.Parameters.AddWithValue("@cat", cat);
                    Debug.WriteLine("DB " + cat);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public void Up_EXP_Category(string ct, string cat)
        {
            using (conn)
            {
                string query = "update EXP_Categories set Category = @cat where Category=@ct";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@ct", ct);
                    Debug.WriteLine("DB " + ct);
                    cmd.Parameters.AddWithValue("@cat", cat);
                    Debug.WriteLine("DB " + cat);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void Delete_INC_Category(string cat)
        {
            using (conn)
            {
                string query = "delete from INC_Categories where Category=@cat";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@cat", cat);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        public void Delete_EXP_Category(string cat)
        {
            using (conn)
            {
                string query = "delete from EXP_Categories where Category=@cat";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@cat", cat);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
        public bool ValidateUserCredentials(string username, string password)
        {
            using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
            {
                string query = "SELECT COUNT(*) FROM us WHERE uname COLLATE Latin1_General_CS_AS = @username AND upass = @password";
                SqlCommand command = new SqlCommand(query, conn);
                command.Parameters.AddWithValue("@username", username);
                command.Parameters.AddWithValue("@password", password);
                conn.Open();

                int result = (int)command.ExecuteScalar();
                return result > 0;
            }
        }
        public string GetUserId(string username)
        {
            using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
            {
                string query = "SELECT UID FROM us WHERE uname = @username";
                SqlCommand command = new SqlCommand(query, conn);
                command.Parameters.AddWithValue("@username", username);
                conn.Open();

                var result = command.ExecuteScalar();
                return result?.ToString();
            }
        }


    }
}



