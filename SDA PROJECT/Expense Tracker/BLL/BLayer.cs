
using System;
using System.Data.SqlClient;
using DAL;
namespace BLL
{
   
    public interface IDataAccessAdapter
    {
        void Signup(string name, DateTime dob, int pass, string email);
        void InsertIncome(string name, int amount, string cat, string incuser, DateTime date, string desc);
        void InsertExpense(string name, int amount, string cat, string expuser, DateTime date, string desc);
        object ViewExpense(string incuser);
        object ViewIncome(string expuser);
        void Insert_INC_Category(string cat);
        void Insert_EXP_Category(string cat);
        object ViewIncomeCategory();
        object ViewExpenseCategory();
        void Delete_INC_Category(string cat);
        void Delete_EXP_Category(string cat);
        void DeleteExpense(int name);
        void DeleteIncome(int id);
    }


    public class DataAccessAdapter : IDataAccessAdapter
    {
        private readonly DataLayer _dataLayer;

        public DataAccessAdapter()
        {
            _dataLayer = new DataLayer();
        }

        public void Signup(string name, DateTime dob, int pass, string email)
        {
            _dataLayer.Signup(name, dob, pass, email);
        }

        public void InsertIncome(string name, int amount, string cat, string incuser, DateTime date, string desc)
        {
            _dataLayer.InsertIncome(name, amount, cat, incuser, date, desc);
        }

        public void InsertExpense(string name, int amount, string cat, string expuser, DateTime date, string desc)
        {
            _dataLayer.InsertExpense(name, amount, cat, expuser, date, desc);
        }

        public object ViewExpense(string incuser)
        {
            return _dataLayer.ViewExpense(incuser);
        }

        public object ViewIncome(string expuser)
        {
            return _dataLayer.ViewIncome(expuser);
        }

        public void Insert_INC_Category(string cat)
        {
            _dataLayer.Insert_INC_Category(cat);
        }

        public void Insert_EXP_Category(string cat)
        {
            _dataLayer.Insert_EXP_Category(cat);
        }

        public object ViewIncomeCategory()
        {
            return _dataLayer.ViewIncomeCategory();
        }

        public object ViewExpenseCategory()
        {
            return _dataLayer.ViewExpenseCategory();
        }

        public void Delete_INC_Category(string cat)
        {
            _dataLayer.Delete_INC_Category(cat);
        }

        public void Delete_EXP_Category(string cat)
        {
            _dataLayer.Delete_EXP_Category(cat);
        }


        public void DeleteExpense(int id)
        {
            _dataLayer.DeleteExpense(id);
        }

        public void DeleteIncome(int id)
        {
            _dataLayer.DeleteIncome(id);
        }
    }

    public class BLayer
    {
        private readonly IDataAccessAdapter _dataAccessAdapter;

        public BLayer(IDataAccessAdapter dataAccessAdapter)
        {
            _dataAccessAdapter = dataAccessAdapter;
        }

        public void Signup(string name, DateTime dob, int pass, string email)
        {
            _dataAccessAdapter.Signup(name, dob, pass, email);
        }

        public void InsertIncome(string name, int amount, string cat, string incuser, DateTime date, string desc)
        {
            try
            {
                _dataAccessAdapter.InsertIncome(name, amount, cat, incuser, date, desc);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("An error occurred in the business layer: " + ex.Message);
            }
        }

        public void InsertExpense(string name, int amount, string cat, string expuser, DateTime date, string desc)
        {
            try
            {
                _dataAccessAdapter.InsertExpense(name, amount, cat, expuser, date, desc);
            }
            catch (Exception ex)
            {
                throw new ApplicationException("An error occurred in the business layer: " + ex.Message);
            }
        }

        public object ViewExpense(string incuser)
        {
            return _dataAccessAdapter.ViewExpense(incuser);
        }

        public object ViewIncome(string expuser)
        {
            return _dataAccessAdapter.ViewIncome(expuser);
        }

        public void Insert_INC_Category(string cat)
        {
            _dataAccessAdapter.Insert_INC_Category(cat);
        }

        public void Insert_EXP_Category(string cat)
        {
            _dataAccessAdapter.Insert_EXP_Category(cat);
        }

        public object ViewIncomeCategory()
        {
            return _dataAccessAdapter.ViewIncomeCategory();
        }

        public object ViewExpenseCategory()
        {
            return _dataAccessAdapter.ViewExpenseCategory();
        }

        public void Delete_INC_Category(string cat)
        {
            _dataAccessAdapter.Delete_INC_Category(cat);
        }

        public void Delete_EXP_Category(string cat)
        {
            _dataAccessAdapter.Delete_EXP_Category(cat);
        }

        public void DeleteExpense(int id)
        {
            _dataAccessAdapter.DeleteExpense(id);
        }

        public void DeleteIncome(int id)
        {
            _dataAccessAdapter.DeleteIncome(id);
        }

        public bool INC_CategoryExists(string categoryName)
        {
            string query = "SELECT COUNT(*) FROM INC_Categories WHERE Category = @CategoryName";
            using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }
        public bool ExpenseCategoryExists(string categoryName)
        {
            
            string query = "SELECT COUNT(*) FROM EXP_Categories WHERE CategoryName = @CategoryName";
            using (SqlConnection conn = new SqlConnection("Data Source=localhost\\SQLEXPRESS02;Initial Catalog=SDA;Integrated Security=True"))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@CategoryName", categoryName);
                    conn.Open();
                    int count = (int)cmd.ExecuteScalar();
                    return count > 0;
                }
            }
        }

    }
    public class AuthenticationService
    {
        private readonly DataLayer _userRepository;

        public AuthenticationService()
        {
            _userRepository = new DataLayer();
        }

        public bool AuthenticateUser(string username, string password)
        {
            bool isAuthenticated = _userRepository.ValidateUserCredentials(username, password);

            if (isAuthenticated)
            {
                var userId = _userRepository.GetUserId(username);
                var sessionId = Guid.NewGuid().ToString();

                lock (UserSessionManager.Instance)
                {
                    if (UserSessionManager.Instance.IsAnyUserLoggedIn())
                    {
                        throw new Exception("Another user is already logged in");
                    }

                    if (UserSessionManager.Instance.IsUserLoggedIn(userId))
                    {
                        throw new Exception("User is already logged in from another session");
                    }
                    else
                    {
                        UserSessionManager.Instance.LoginUser(userId, sessionId);
                        // Set the session ID in the UI layer (e.g., in cookies or session storage)
                        return true;
                    }
                }
            }
            return false;
        }

        public string Uid(string id)
        {
            return _userRepository.GetUserId(id);
        }

        public void LogoutUser(string userId)
        {
            UserSessionManager.Instance.LogoutUser(userId);
        }
    }
}

