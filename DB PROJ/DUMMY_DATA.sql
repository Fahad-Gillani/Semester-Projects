-- User Table
CREATE TABLE us (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    RegistrationDate DATE
);
-- Category Table
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255),
    Cat_Type varchar(20) check (Cat_Type in('Income', 'Expense')),
    DefaultBudget DECIMAL(10, 2)
);
-- Transaction Table
CREATE TABLE trans (
    TransactionID INT PRIMARY KEY,
    UserID INT,
    Date DATE,
    Amount DECIMAL(10, 2),
    CategoryID INT,
    Trans_Type varchar(20) check (Trans_Type in ('Income', 'Expense')),
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES us(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);


-- Budget Table
CREATE TABLE Budget (
    BudgetID INT PRIMARY KEY,
    UserID INT,
    CategoryID INT,
    BudgetAmount DECIMAL(10, 2),
    Month INT,
    Year INT,
    FOREIGN KEY (UserID) REFERENCES us(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Goal Table
CREATE TABLE Goal (
    GoalID INT PRIMARY KEY,
    UserID INT,
    GoalName VARCHAR(255),
    TargetAmount DECIMAL(10, 2),
    TargetDate DATE,
    CurrentProgress DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Notification Table
CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    UserID INT,
    NotificationType VARCHAR(50),
    NotificationTrigger VARCHAR(50),
    NotificationFrequency VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Income Source Table
CREATE TABLE IncomeSource (
    SourceID INT PRIMARY KEY,
    UserID INT,
    SourceName VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Expense Frequency Table
CREATE TABLE ExpenseFrequency (
    FrequencyID INT PRIMARY KEY,
    FrequencyType VARCHAR(50),
    Description TEXT
);

-- Recurring Expenses Table
CREATE TABLE RecurringExpense (
    RecurringExpenseID INT PRIMARY KEY,
    UserID INT,
    ExpenseName VARCHAR(255),
    Amount DECIMAL(10, 2),
    CategoryID INT,
    FrequencyID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES us(UserID),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (FrequencyID) REFERENCES ExpenseFrequency(FrequencyID)
);

-- Payment Method Table
CREATE TABLE PaymentMethod (
    MethodID INT PRIMARY KEY,
    UserID INT,
    MethodName VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Income Schedule Table
CREATE TABLE IncomeSchedule (
    ScheduleID INT PRIMARY KEY,
    UserID INT,
    SourceID INT,
    Amount DECIMAL(10, 2),
    FrequencyID INT,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (UserID) REFERENCES us(UserID),
    FOREIGN KEY (SourceID) REFERENCES IncomeSource(SourceID),
    FOREIGN KEY (FrequencyID) REFERENCES ExpenseFrequency(FrequencyID)
);

-- Savings Goal Progress Table
CREATE TABLE SavingsGoalProgress (
    ProgressID INT PRIMARY KEY,
    GoalID INT,
    ProgressDate DATE,
    AmountSaved DECIMAL(10, 2),
    FOREIGN KEY (GoalID) REFERENCES Goal(GoalID)
);

-- Debt Table
CREATE TABLE Debt (
    DebtID INT PRIMARY KEY,
    UserID INT,
    Creditor VARCHAR(255),
    DebtAmount DECIMAL(10, 2),
    InterestRate DECIMAL(5, 2),
    MinimumPayment DECIMAL(10, 2),
    PaymentDueDate DATE,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Investment Table
CREATE TABLE Investment (
    InvestmentID INT PRIMARY KEY,
    UserID INT,
    InvestmentName VARCHAR(255),
    Description TEXT,
    InvestmentAmount DECIMAL(10, 2),
    InvestmentDate DATE,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Asset Table
CREATE TABLE Asset (
    AssetID INT PRIMARY KEY,
    UserID INT,
    AssetName VARCHAR(255),
    Description TEXT,
    EstimatedValue DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

-- Insert into us (User Table)
INSERT INTO us (UserID, Username, Password, RegistrationDate)
VALUES
    (1, 'user1', 'password1', '2024-01-01'),
    (2, 'user2', 'password2', '2024-01-02'),
    (3, 'user3', 'password3', '2024-01-03'),
    (4, 'user4', 'password4', '2024-01-04'),
    (5, 'user5', 'password5', '2024-01-05');

-- Insert into Category (Category Table)
INSERT INTO Category (CategoryID, CategoryName, Cat_Type, DefaultBudget)
VALUES
    (1, 'Salary', 'Income', 0),
    (2, 'Groceries', 'Expense', 200),
    (3, 'Rent', 'Expense', 1000),
    (4, 'Utilities', 'Expense', 150),
    (5, 'Entertainment', 'Expense', 100);

-- Insert into trans (Transaction Table)
INSERT INTO trans (TransactionID, UserID, Date, Amount, CategoryID, Trans_Type, Description)
VALUES
    (1, 1, '2024-01-01', 1500, 1, 'Income', 'Salary'),
    (2, 1, '2024-01-05', 120, 2, 'Expense', 'Groceries'),
    (3, 2, '2024-01-10', 1100, 1, 'Income', 'Salary'),
    (4, 2, '2024-01-15', 90, 2, 'Expense', 'Groceries'),
    (5, 3, '2024-01-20', 1300, 1, 'Income', 'Salary');

-- Insert into Budget (Budget Table)
INSERT INTO Budget (BudgetID, UserID, CategoryID, BudgetAmount, Month, Year)
VALUES
    (1, 1, 2, 200, 1, 2024),
    (2, 1, 3, 1000, 1, 2024),
    (3, 2, 2, 250, 1, 2024),
    (4, 2, 4, 200, 1, 2024),
    (5, 3, 2, 300, 1, 2024);

-- Insert into Goal (Goal Table)
INSERT INTO Goal (GoalID, UserID, GoalName, TargetAmount, TargetDate, CurrentProgress)
VALUES
    (1, 1, 'Save for vacation', 500, '2024-06-01', 250),
    (2, 1, 'Buy a new laptop', 1000, '2024-07-01', 200),
    (3, 2, 'Emergency fund', 1000, '2024-06-01', 500),
    (4, 3, 'Save for car', 5000, '2024-12-01', 1000),
    (5, 4, 'Home renovation', 2000, '2024-09-01', 300);

-- Insert into Notification (Notification Table)
INSERT INTO Notification (NotificationID, UserID, NotificationType, NotificationTrigger, NotificationFrequency)
VALUES
    (1, 1, 'Email', 'Monthly Budget Exceeded', 'Monthly'),
    (2, 1, 'SMS', 'Goal Deadline Approaching', 'Weekly'),
    (3, 2, 'Email', 'Weekly Spending Report', 'Weekly'),
    (4, 3, 'SMS', 'Budget Overridden', 'As Needed'),
    (5, 4, 'Email', 'Debt Payment Reminder', 'Monthly');

-- Insert into IncomeSource (Income Source Table)
INSERT INTO IncomeSource (SourceID, UserID, SourceName, Description)
VALUES
    (1, 1, 'Primary Job', 'Monthly salary'),
    (2, 2, 'Freelancing', 'Extra income'),
    (3, 3, 'Part-time Job', 'Additional income'),
    (4, 4, 'Investments', 'Dividend income'),
    (5, 5, 'Rental Property', 'Rental income');

-- Insert into ExpenseFrequency (Expense Frequency Table)
INSERT INTO ExpenseFrequency (FrequencyID, FrequencyType, Description)
VALUES
    (1, 'Weekly', 'Occurs every week'),
    (2, 'Monthly', 'Occurs every month'),
    (3, 'Quarterly', 'Occurs every quarter'),
    (4, 'Yearly', 'Occurs every year'),
    (5, 'As Needed', 'Occurs as required');

-- Insert into RecurringExpense (Recurring Expenses Table)
INSERT INTO RecurringExpense (RecurringExpenseID, UserID, ExpenseName, Amount, CategoryID, FrequencyID, StartDate, EndDate)
VALUES
    (1, 1, 'Rent', 1000, 3, 2, '2024-01-01', '2024-12-31'),
    (2, 2, 'Groceries', 200, 2, 1, '2024-01-01', '2024-12-31'),
    (3, 3, 'Utilities', 150, 4, 2, '2024-01-01', '2024-12-31'),
    (4, 4, 'Transportation', 100, 5, 2, '2024-01-01', '2024-12-31'),
    (5, 5, 'Entertainment', 100, 5, 3, '2024-01-01', '2024-12-31');

-- Insert into PaymentMethod (Payment Method Table)
INSERT INTO PaymentMethod (MethodID, UserID, MethodName, Description)
VALUES
    (1, 1, 'Credit Card', 'Used for online purchases'),
    (2, 2, 'Cash', 'Preferred for daily expenses'),
    (3, 3, 'Debit Card', 'For ATM withdrawals'),
    (4, 4, 'Bank Transfer', 'For bill payments'),
    (5, 5, 'PayPal', 'For international transactions');

-- Insert into IncomeSchedule (Income Schedule Table)
INSERT INTO IncomeSchedule (ScheduleID, UserID, SourceID, Amount, FrequencyID, StartDate, EndDate)
VALUES
    (1, 1, 1, 1500, 2, '2024-01-01', '2024-12-31'),
    (2, 2, 2, 100, 3, '2024-01-01', '2024-12-31'),
    (3, 3, 3, 500, 4, '2024-01-01', '2024-12-31'),
    (4, 4, 4, 200, 5, '2024-01-01', '2024-12-31'),
    (5, 5, 5, 300, 1, '2024-01-01', '2024-12-31');

-- Insert into SavingsGoalProgress (Savings Goal Progress Table)
INSERT INTO SavingsGoalProgress (ProgressID, GoalID, ProgressDate, AmountSaved)
VALUES
    (1, 1, '2024-01-15', 150),
    (2, 1, '2024-02-15', 200),
    (3, 2, '2024-01-15', 100),
    (4, 2, '2024-02-15', 200),
    (5, 3, '2024-01-15', 300);

-- Insert into Debt (Debt Table)
INSERT INTO Debt (DebtID, UserID, Creditor, DebtAmount, InterestRate, MinimumPayment, PaymentDueDate)
VALUES
    (1, 1, 'Credit Card Company', 5000, 18, 200, '2024-01-20'),
    (2, 2, 'Bank', 10000, 10, 300, '2024-01-25'),
    (3, 3, 'Loan Provider', 8000, 12, 250, '2024-01-30'),
    (4, 4, 'Finance Company', 6000, 15, 220, '2024-02-05'),
    (5, 5, 'Mortgage Provider', 200000, 4, 1000, '2024-02-10');

-- Insert into Investment (Investment Table)
INSERT INTO Investment (InvestmentID, UserID, InvestmentName, Description, InvestmentAmount, InvestmentDate)
VALUES
    (1, 1, 'Stocks', 'Investment in stocks', 5000, '2024-01-01'),
    (2, 2, 'Bonds', 'Investment in bonds', 10000, '2024-01-05'),
    (3, 3, 'Mutual Funds', 'Investment in mutual funds', 8000, '2024-01-10'),
    (4, 4, 'Real Estate', 'Investment in real estate', 6000, '2024-01-15'),
    (5, 5, 'Cryptocurrency', 'Investment in cryptocurrency', 200000, '2024-01-20');

-- Insert into Asset (Asset Table)
INSERT INTO Asset (AssetID, UserID, AssetName, Description, EstimatedValue)
VALUES
    (1, 1, 'Car', 'Car owned by user', 15000),
    (2, 2, 'House', 'Property owned by user', 200000),
    (3, 3, 'Jewelry', 'Valuable jewelry owned by user', 5000),
    (4, 4, 'Artwork', 'Artwork owned by user', 10000),
    (5, 5, 'Electronics', 'Electronic devices owned by user', 8000);
-- Select all records from us (User Table)
SELECT * FROM us;

-- Select all records from Category (Category Table)
SELECT * FROM Category;

-- Select all records from trans (Transaction Table)
SELECT * FROM trans;

-- Select all records from Budget (Budget Table)
SELECT * FROM Budget;

-- Select all records from Goal (Goal Table)
SELECT * FROM Goal;

-- Select all records from Notification (Notification Table)
SELECT * FROM Notification;

-- Select all records from IncomeSource (Income Source Table)
SELECT * FROM IncomeSource;

-- Select all records from ExpenseFrequency (Expense Frequency Table)
SELECT * FROM ExpenseFrequency;

-- Select all records from RecurringExpense (Recurring Expenses Table)
SELECT * FROM RecurringExpense;

-- Select all records from PaymentMethod (Payment Method Table)
SELECT * FROM PaymentMethod;

-- Select all records from IncomeSchedule (Income Schedule Table)
SELECT * FROM IncomeSchedule;

-- Select all records from SavingsGoalProgress (Savings Goal Progress Table)
SELECT * FROM SavingsGoalProgress;

-- Select all records from Debt (Debt Table)
SELECT * FROM Debt;

-- Select all records from Investment (Investment Table)
SELECT * FROM Investment;

-- Select all records from Asset (Asset Table)
SELECT * FROM Asset;
