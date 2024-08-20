 
CREATE TABLE us (
    UserID INT PRIMARY KEY,
    Username VARCHAR(255) NOT NULL,
    Password VARCHAR(255) NOT NULL,
    RegistrationDate DATE
);
 
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(255),
    Cat_Type varchar(20) check (Cat_Type in('Income', 'Expense')),
    DefaultBudget DECIMAL(10, 2)
);
 
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

 
CREATE TABLE Goal (
    GoalID INT PRIMARY KEY,
    UserID INT,
    GoalName VARCHAR(255),
    TargetAmount DECIMAL(10, 2),
    TargetDate DATE,
    CurrentProgress DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);
 
CREATE TABLE Notification (
    NotificationID INT PRIMARY KEY,
    UserID INT,
    NotificationType VARCHAR(50),
    NotificationTrigger VARCHAR(50),
    NotificationFrequency VARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

 
CREATE TABLE IncomeSource (
    SourceID INT PRIMARY KEY,
    UserID INT,
    SourceName VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);

 
CREATE TABLE ExpenseFrequency (
    FrequencyID INT PRIMARY KEY,
    FrequencyType VARCHAR(50),
    Description TEXT
);

 
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

 
CREATE TABLE PaymentMethod (
    MethodID INT PRIMARY KEY,
    UserID INT,
    MethodName VARCHAR(255),
    Description TEXT,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);
 
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
 
CREATE TABLE SavingsGoalProgress (
    ProgressID INT PRIMARY KEY,
    GoalID INT,
    ProgressDate DATE,
    AmountSaved DECIMAL(10, 2),
    FOREIGN KEY (GoalID) REFERENCES Goal(GoalID)
);
 
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

CREATE TABLE Investment (
    InvestmentID INT PRIMARY KEY,
    UserID INT,
    InvestmentName VARCHAR(255),
    Description TEXT,
    InvestmentAmount DECIMAL(10, 2),
    InvestmentDate DATE,
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);
 
CREATE TABLE Asset (
    AssetID INT PRIMARY KEY,
    UserID INT,
    AssetName VARCHAR(255),
    Description TEXT,
    EstimatedValue DECIMAL(10, 2),
    FOREIGN KEY (UserID) REFERENCES us(UserID)
);
