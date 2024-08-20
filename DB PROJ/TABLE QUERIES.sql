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

--TABLES OF TRIGGERS

CREATE TABLE AUDIT_DATABASE(ID INT PRIMARY KEY IDENTITY(1,1),
Table_Name varchar(255),Operation varchar(255), TimeStamp datetime)