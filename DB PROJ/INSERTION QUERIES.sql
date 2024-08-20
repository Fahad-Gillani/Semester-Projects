INSERT INTO us (UserID, Username, Password, RegistrationDate)
VALUES
    (1, 'user1', 'password1', '2024-01-01'),
    (2, 'user2', 'password2', '2024-01-02'),
    (3, 'user3', 'password3', '2024-01-03'),
    (4, 'user4', 'password4', '2024-01-04'),
    (5, 'user5', 'password5', '2024-01-05');
 
INSERT INTO Category (CategoryID, CategoryName, Cat_Type, DefaultBudget)
VALUES
    (1, 'Salary', 'Income', 0),
    (2, 'Groceries', 'Expense', 200),
    (3, 'Rent', 'Expense', 1000),
    (4, 'Utilities', 'Expense', 150),
    (5, 'Entertainment', 'Expense', 100);
 
INSERT INTO trans (TransactionID, UserID, Date, Amount, CategoryID, Trans_Type, Description)
VALUES
    (1, 1, '2024-01-01', 1500, 1, 'Income', 'Salary'),
    (2, 1, '2024-01-05', 120, 2, 'Expense', 'Groceries'),
    (3, 2, '2024-01-10', 1100, 1, 'Income', 'Salary'),
    (4, 2, '2024-01-15', 90, 2, 'Expense', 'Groceries'),
    (5, 3, '2024-01-20', 1300, 1, 'Income', 'Salary');
 
INSERT INTO Budget (BudgetID, UserID, CategoryID, BudgetAmount, Month, Year)
VALUES
    (1, 1, 2, 200, 1, 2024),
    (2, 1, 3, 1000, 1, 2024),
    (3, 2, 2, 250, 1, 2024),
    (4, 2, 4, 200, 1, 2024),
    (5, 3, 2, 300, 1, 2024);
 
INSERT INTO Goal (GoalID, UserID, GoalName, TargetAmount, TargetDate, CurrentProgress)
VALUES
    (1, 1, 'Save for vacation', 500, '2024-06-01', 250),
    (2, 1, 'Buy a new laptop', 1000, '2024-07-01', 200),
    (3, 2, 'Emergency fund', 1000, '2024-06-01', 500),
    (4, 3, 'Save for car', 5000, '2024-12-01', 1000),
    (5, 4, 'Home renovation', 2000, '2024-09-01', 300);

 
INSERT INTO Notification (NotificationID, UserID, NotificationType, NotificationTrigger, NotificationFrequency)
VALUES
    (1, 1, 'Email', 'Monthly Budget Exceeded', 'Monthly'),
    (2, 1, 'SMS', 'Goal Deadline Approaching', 'Weekly'),
    (3, 2, 'Email', 'Weekly Spending Report', 'Weekly'),
    (4, 3, 'SMS', 'Budget Overridden', 'As Needed'),
    (5, 4, 'Email', 'Debt Payment Reminder', 'Monthly');

 
INSERT INTO IncomeSource (SourceID, UserID, SourceName, Description)
VALUES
    (1, 1, 'Primary Job', 'Monthly salary'),
    (2, 2, 'Freelancing', 'Extra income'),
    (3, 3, 'Part-time Job', 'Additional income'),
    (4, 4, 'Investments', 'Dividend income'),
    (5, 5, 'Rental Property', 'Rental income');
 
INSERT INTO ExpenseFrequency (FrequencyID, FrequencyType, Description)
VALUES
    (1, 'Weekly', 'Occurs every week'),
    (2, 'Monthly', 'Occurs every month'),
    (3, 'Quarterly', 'Occurs every quarter'),
    (4, 'Yearly', 'Occurs every year'),
    (5, 'As Needed', 'Occurs as required');
 
INSERT INTO RecurringExpense (RecurringExpenseID, UserID, ExpenseName, Amount, CategoryID, FrequencyID, StartDate, EndDate)
VALUES
    (1, 1, 'Rent', 1000, 3, 2, '2024-01-01', '2024-12-31'),
    (2, 2, 'Groceries', 200, 2, 1, '2024-01-01', '2024-12-31'),
    (3, 3, 'Utilities', 150, 4, 2, '2024-01-01', '2024-12-31'),
    (4, 4, 'Transportation', 100, 5, 2, '2024-01-01', '2024-12-31'),
    (5, 5, 'Entertainment', 100, 5, 3, '2024-01-01', '2024-12-31');

 
INSERT INTO PaymentMethod (MethodID, UserID, MethodName, Description)
VALUES
    (1, 1, 'Credit Card', 'Used for online purchases'),
    (2, 2, 'Cash', 'Preferred for daily expenses'),
    (3, 3, 'Debit Card', 'For ATM withdrawals'),
    (4, 4, 'Bank Transfer', 'For bill payments'),
    (5, 5, 'PayPal', 'For international transactions');
 
INSERT INTO IncomeSchedule (ScheduleID, UserID, SourceID, Amount, FrequencyID, StartDate, EndDate)
VALUES
    (1, 1, 1, 1500, 2, '2024-01-01', '2024-12-31'),
    (2, 2, 2, 100, 3, '2024-01-01', '2024-12-31'),
    (3, 3, 3, 500, 4, '2024-01-01', '2024-12-31'),
    (4, 4, 4, 200, 5, '2024-01-01', '2024-12-31'),
    (5, 5, 5, 300, 1, '2024-01-01', '2024-12-31');
 
INSERT INTO SavingsGoalProgress (ProgressID, GoalID, ProgressDate, AmountSaved)
VALUES
    (1, 1, '2024-01-15', 150),
    (2, 1, '2024-02-15', 200),
    (3, 2, '2024-01-15', 100),
    (4, 2, '2024-02-15', 200),
    (5, 3, '2024-01-15', 300);
 
INSERT INTO Debt (DebtID, UserID, Creditor, DebtAmount, InterestRate, MinimumPayment, PaymentDueDate)
VALUES
    (1, 1, 'Credit Card Company', 5000, 18, 200, '2024-01-20'),
    (2, 2, 'Bank', 10000, 10, 300, '2024-01-25'),
    (3, 3, 'Loan Provider', 8000, 12, 250, '2024-01-30'),
    (4, 4, 'Finance Company', 6000, 15, 220, '2024-02-05'),
    (5, 5, 'Mortgage Provider', 200000, 4, 1000, '2024-02-10');
 
INSERT INTO Investment (InvestmentID, UserID, InvestmentName, Description, InvestmentAmount, InvestmentDate)
VALUES
    (1, 1, 'Stocks', 'Investment in stocks', 5000, '2024-01-01'),
    (2, 2, 'Bonds', 'Investment in bonds', 10000, '2024-01-05'),
    (3, 3, 'Mutual Funds', 'Investment in mutual funds', 8000, '2024-01-10'),
    (4, 4, 'Real Estate', 'Investment in real estate', 6000, '2024-01-15'),
    (5, 5, 'Cryptocurrency', 'Investment in cryptocurrency', 200000, '2024-01-20');

INSERT INTO Asset (AssetID, UserID, AssetName, Description, EstimatedValue)
VALUES
    (1, 1, 'Car', 'Car owned by user', 15000),
    (2, 2, 'House', 'Property owned by user', 200000),
    (3, 3, 'Jewelry', 'Valuable jewelry owned by user', 5000),
    (4, 4, 'Artwork', 'Artwork owned by user', 10000),
    (5, 5, 'Electronics', 'Electronic devices owned by user', 8000);