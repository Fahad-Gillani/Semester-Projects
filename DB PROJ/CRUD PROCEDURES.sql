--USER TABLE
CREATE PROCEDURE CreateUser (
    @UserID INT,
    @Username VARCHAR(255),
    @Password VARCHAR(255),
    @RegistrationDate DATE
)
AS
BEGIN
    INSERT INTO us (UserID, Username, Password, RegistrationDate)
    VALUES (@UserID, @Username, @Password, @RegistrationDate)
END;

CREATE PROCEDURE GetUserByID (
    @UserID INT
)
AS
BEGIN
    SELECT * FROM us WHERE UserID = @UserID
END;

CREATE PROCEDURE UpdateUser (
    @UserID INT,
    @Username VARCHAR(255),
    @Password VARCHAR(255),
    @RegistrationDate DATE
)
AS
BEGIN
    UPDATE us
    SET Username = @Username,
        Password = @Password,
        RegistrationDate = @RegistrationDate
    WHERE UserID = @UserID
END;

CREATE PROCEDURE DeleteUser (
    @UserID INT
)
AS
BEGIN
    DELETE FROM us WHERE UserID = @UserID
END;

--CATEGORY TABLE
CREATE PROCEDURE CreateCategory (
    @CategoryID INT,
    @CategoryName VARCHAR(255),
    @Cat_Type VARCHAR(20),
    @DefaultBudget DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO Category (CategoryID, CategoryName, Cat_Type, DefaultBudget)
    VALUES (@CategoryID, @CategoryName, @Cat_Type, @DefaultBudget)
END;

CREATE PROCEDURE GetCategoryByID (
    @CategoryID INT
)
AS
BEGIN
    SELECT * FROM Category WHERE CategoryID = @CategoryID
END;

CREATE PROCEDURE UpdateCategory (
    @CategoryID INT,
    @CategoryName VARCHAR(255),
    @Cat_Type VARCHAR(20),
    @DefaultBudget DECIMAL(10, 2)
)
AS
BEGIN
    UPDATE Category
    SET CategoryName = @CategoryName,
        Cat_Type = @Cat_Type,
        DefaultBudget = @DefaultBudget
    WHERE CategoryID = @CategoryID
END;

CREATE PROCEDURE DeleteCategory (
    @CategoryID INT
)
AS
BEGIN
    DELETE FROM Category WHERE CategoryID = @CategoryID
END;

--TRANSACTION TABLE

CREATE PROCEDURE CreateTransaction (
    @TransactionID INT,
    @UserID INT,
    @Date DATE,
    @Amount DECIMAL(10, 2),
    @CategoryID INT,
    @Trans_Type VARCHAR(20),
    @Description TEXT
)
AS
BEGIN
    INSERT INTO trans (TransactionID, UserID, Date, Amount, CategoryID, Trans_Type, Description)
    VALUES (@TransactionID, @UserID, @Date, @Amount, @CategoryID, @Trans_Type, @Description)
END;

 
CREATE PROCEDURE GetTransactionByID (
    @TransactionID INT
)
AS
BEGIN
    SELECT * FROM trans WHERE TransactionID = @TransactionID
END;

 
CREATE PROCEDURE UpdateTransaction (
    @TransactionID INT,
    @UserID INT,
    @Date DATE,
    @Amount DECIMAL(10, 2),
    @CategoryID INT,
    @Trans_Type VARCHAR(20),
    @Description TEXT
)
AS
BEGIN
    UPDATE trans
    SET UserID = @UserID,
        Date = @Date,
        Amount = @Amount,
        CategoryID = @CategoryID,
        Trans_Type = @Trans_Type,
        Description = @Description
    WHERE TransactionID = @TransactionID
END;

 
CREATE PROCEDURE DeleteTransaction (
    @TransactionID INT
)
AS
BEGIN
    DELETE FROM trans WHERE TransactionID = @TransactionID
END;

--BUDGET TABLE
 
CREATE PROCEDURE CreateBudget (
    @BudgetID INT,
    @UserID INT,
    @CategoryID INT,
    @BudgetAmount DECIMAL(10, 2),
    @Month INT,
    @Year INT
)
AS
BEGIN
    INSERT INTO Budget (BudgetID, UserID, CategoryID, BudgetAmount, Month, Year)
    VALUES (@BudgetID, @UserID, @CategoryID, @BudgetAmount, @Month, @Year)
END;

 
CREATE PROCEDURE GetBudgetByID (
    @BudgetID INT
)
AS
BEGIN
    SELECT * FROM Budget WHERE BudgetID = @BudgetID
END;
 
CREATE PROCEDURE UpdateBudget (
    @BudgetID INT,
    @UserID INT,
    @CategoryID INT,
    @BudgetAmount DECIMAL(10, 2),
    @Month INT,
    @Year INT
)
AS
BEGIN
    UPDATE Budget
    SET UserID = @UserID,
        CategoryID = @CategoryID,
        BudgetAmount = @BudgetAmount,
        Month = @Month,
        Year = @Year
    WHERE BudgetID = @BudgetID
END;
 
CREATE PROCEDURE DeleteBudget (
    @BudgetID INT
)
AS
BEGIN
    DELETE FROM Budget WHERE BudgetID = @BudgetID
END;

--GOAL TABLE
 
CREATE PROCEDURE CreateGoal (
    @GoalID INT,
    @UserID INT,
    @GoalName VARCHAR(255),
    @TargetAmount DECIMAL(10, 2),
    @TargetDate DATE,
    @CurrentProgress DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO Goal (GoalID, UserID, GoalName, TargetAmount, TargetDate, CurrentProgress)
    VALUES (@GoalID, @UserID, @GoalName, @TargetAmount, @TargetDate, @CurrentProgress)
END;

 
CREATE PROCEDURE GetGoalByID (
    @GoalID INT
)
AS
BEGIN
    SELECT * FROM Goal WHERE GoalID = @GoalID
END;

 
CREATE PROCEDURE UpdateGoal (
    @GoalID INT,
    @UserID INT,
    @GoalName VARCHAR(255),
    @TargetAmount DECIMAL(10, 2),
    @TargetDate DATE,
    @CurrentProgress DECIMAL(10, 2)
)
AS
BEGIN
    UPDATE Goal
    SET UserID = @UserID,
        GoalName = @GoalName,
        TargetAmount = @TargetAmount,
        TargetDate = @TargetDate,
        CurrentProgress = @CurrentProgress
    WHERE GoalID = @GoalID
END;

 
CREATE PROCEDURE DeleteGoal (
    @GoalID INT
)
AS
BEGIN
    DELETE FROM Goal WHERE GoalID = @GoalID
END;

--NOTIFICATION TABLE

 
CREATE PROCEDURE CreateNotification (
    @NotificationID INT,
    @UserID INT,
    @NotificationType VARCHAR(50),
    @NotificationTrigger VARCHAR(50),
    @NotificationFrequency VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Notification (NotificationID, UserID, NotificationType, NotificationTrigger, NotificationFrequency)
    VALUES (@NotificationID, @UserID, @NotificationType, @NotificationTrigger, @NotificationFrequency)
END;

 
CREATE PROCEDURE GetNotificationByID (
    @NotificationID INT
)
AS
BEGIN
    SELECT * FROM Notification WHERE NotificationID = @NotificationID
END;
 
CREATE PROCEDURE UpdateNotification (
    @NotificationID INT,
    @UserID INT,
    @NotificationType VARCHAR(50),
    @NotificationTrigger VARCHAR(50),
    @NotificationFrequency VARCHAR(50)
)
AS
BEGIN
    UPDATE Notification
    SET UserID = @UserID,
        NotificationType = @NotificationType,
        NotificationTrigger = @NotificationTrigger,
        NotificationFrequency = @NotificationFrequency
    WHERE NotificationID = @NotificationID
END;

 
CREATE PROCEDURE DeleteNotification (
    @NotificationID INT
)
AS
BEGIN
    DELETE FROM Notification WHERE NotificationID = @NotificationID
END;

--INCOME TABLE
 
CREATE PROCEDURE CreateIncomeSource (
    @SourceID INT,
    @UserID INT,
    @SourceName VARCHAR(255),
    @Description TEXT
)
AS
BEGIN
    INSERT INTO IncomeSource (SourceID, UserID, SourceName, Description)
    VALUES (@SourceID, @UserID, @SourceName, @Description)
END;

-- READ
CREATE PROCEDURE GetIncomeSourceByID (
    @SourceID INT
)
AS
BEGIN
    SELECT * FROM IncomeSource WHERE SourceID = @SourceID
END;

 
CREATE PROCEDURE UpdateIncomeSource (
    @SourceID INT,
    @UserID INT,
    @SourceName VARCHAR(255),
    @Description TEXT
)
AS
BEGIN
    UPDATE IncomeSource
    SET UserID = @UserID,
        SourceName = @SourceName,
        Description = @Description
    WHERE SourceID = @SourceID
END;

CREATE PROCEDURE DeleteIncomeSource (
    @SourceID INT
)
AS
BEGIN
    DELETE FROM IncomeSource WHERE SourceID = @SourceID
END;

--EXPENSE FREQUENCY TABLE

 
CREATE PROCEDURE CreateExpenseFrequency (
    @FrequencyID INT,
    @FrequencyType VARCHAR(50),
    @Description TEXT
)
AS
BEGIN
    INSERT INTO ExpenseFrequency (FrequencyID, FrequencyType, Description)
    VALUES (@FrequencyID, @FrequencyType, @Description)
END;
 
CREATE PROCEDURE GetExpenseFrequencyByID (
    @FrequencyID INT
)
AS
BEGIN
    SELECT * FROM ExpenseFrequency WHERE FrequencyID = @FrequencyID
END;

 
CREATE PROCEDURE UpdateExpenseFrequency (
    @FrequencyID INT,
    @FrequencyType VARCHAR(50),
    @Description TEXT
)
AS
BEGIN
    UPDATE ExpenseFrequency
    SET FrequencyType = @FrequencyType,
        Description = @Description
    WHERE FrequencyID = @FrequencyID
END;
 
CREATE PROCEDURE DeleteExpenseFrequency (
    @FrequencyID INT
)
AS
BEGIN
    DELETE FROM ExpenseFrequency WHERE FrequencyID = @FrequencyID
END;

--RECURRING EXPENSE TABLE
 
CREATE PROCEDURE CreateRecurringExpense (
    @RecurringExpenseID INT,
    @UserID INT,
    @ExpenseName VARCHAR(255),
    @Amount DECIMAL(10, 2),
    @CategoryID INT,
    @FrequencyID INT,
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN
    INSERT INTO RecurringExpense (RecurringExpenseID, UserID, ExpenseName, Amount, CategoryID, FrequencyID, StartDate, EndDate)
    VALUES (@RecurringExpenseID, @UserID, @ExpenseName, @Amount, @CategoryID, @FrequencyID, @StartDate, @EndDate)
END;
 
CREATE PROCEDURE GetRecurringExpenseByID (
    @RecurringExpenseID INT
)
AS
BEGIN
    SELECT * FROM RecurringExpense WHERE RecurringExpenseID = @RecurringExpenseID
END;
 
CREATE PROCEDURE UpdateRecurringExpense (
    @RecurringExpenseID INT,
    @UserID INT,
    @ExpenseName VARCHAR(255),
    @Amount DECIMAL(10, 2),
    @CategoryID INT,
    @FrequencyID INT,
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN
    UPDATE RecurringExpense
    SET UserID = @UserID,
        ExpenseName = @ExpenseName,
        Amount = @Amount,
        CategoryID = @CategoryID,
        FrequencyID = @FrequencyID,
        StartDate = @StartDate,
        EndDate = @EndDate
    WHERE RecurringExpenseID = @RecurringExpenseID
END;
 
CREATE PROCEDURE DeleteRecurringExpense (
    @RecurringExpenseID INT
)
AS
BEGIN
    DELETE FROM RecurringExpense WHERE RecurringExpenseID = @RecurringExpenseID
END;


--PAYMENT TABLE
 
CREATE PROCEDURE CreatePaymentMethod (
    @MethodID INT,
    @UserID INT,
    @MethodName VARCHAR(255),
    @Description TEXT
)
AS
BEGIN
    INSERT INTO PaymentMethod (MethodID, UserID, MethodName, Description)
    VALUES (@MethodID, @UserID, @MethodName, @Description)
END;
 
CREATE PROCEDURE GetPaymentMethodByID (
    @MethodID INT
)
AS
BEGIN
    SELECT * FROM PaymentMethod WHERE MethodID = @MethodID
END;
 
CREATE PROCEDURE UpdatePaymentMethod (
    @MethodID INT,
    @UserID INT,
    @MethodName VARCHAR(255),
    @Description TEXT
)
AS
BEGIN
    UPDATE PaymentMethod
    SET UserID = @UserID,
        MethodName = @MethodName,
        Description = @Description
    WHERE MethodID = @MethodID
END;
 
CREATE PROCEDURE DeletePaymentMethod (
    @MethodID INT
)
AS
BEGIN
    DELETE FROM PaymentMethod WHERE MethodID = @MethodID
END;

--INCOME SCHEDULE

CREATE PROCEDURE CreateIncomeSchedule (
    @ScheduleID INT,
    @UserID INT,
    @SourceID INT,
    @Amount DECIMAL(10, 2),
    @FrequencyID INT,
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN
    INSERT INTO IncomeSchedule (ScheduleID, UserID, SourceID, Amount, FrequencyID, StartDate, EndDate)
    VALUES (@ScheduleID, @UserID, @SourceID, @Amount, @FrequencyID, @StartDate, @EndDate)
END;
 
CREATE PROCEDURE GetIncomeScheduleByID (
    @ScheduleID INT
)
AS
BEGIN
    SELECT * FROM IncomeSchedule WHERE ScheduleID = @ScheduleID
END;
 
CREATE PROCEDURE UpdateIncomeSchedule (
    @ScheduleID INT,
    @UserID INT,
    @SourceID INT,
    @Amount DECIMAL(10, 2),
    @FrequencyID INT,
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN
    UPDATE IncomeSchedule
    SET UserID = @UserID,
        SourceID = @SourceID,
        Amount = @Amount,
        FrequencyID = @FrequencyID,
        StartDate = @StartDate,
        EndDate = @EndDate
    WHERE ScheduleID = @ScheduleID
END;
 
CREATE PROCEDURE DeleteIncomeSchedule (
    @ScheduleID INT
)
AS
BEGIN
    DELETE FROM IncomeSchedule WHERE ScheduleID = @ScheduleID
END;

--SAVINGS GOAL TABLE
 
CREATE PROCEDURE CreateSavingsGoalProgress (
    @ProgressID INT,
    @GoalID INT,
    @ProgressDate DATE,
    @AmountSaved DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO SavingsGoalProgress (ProgressID, GoalID, ProgressDate, AmountSaved)
    VALUES (@ProgressID, @GoalID, @ProgressDate, @AmountSaved)
END;
 
CREATE PROCEDURE GetSavingsGoalProgressByID (
    @ProgressID INT
)
AS
BEGIN
    SELECT * FROM SavingsGoalProgress WHERE ProgressID = @ProgressID
END;

CREATE PROCEDURE UpdateSavingsGoalProgress (
    @ProgressID INT,
    @GoalID INT,
    @ProgressDate DATE,
    @AmountSaved DECIMAL(10, 2)
)
AS
BEGIN
    UPDATE SavingsGoalProgress
    SET GoalID = @GoalID,
        ProgressDate = @ProgressDate,
        AmountSaved = @AmountSaved
    WHERE ProgressID = @ProgressID
END;
 
CREATE PROCEDURE DeleteSavingsGoalProgress (
    @ProgressID INT
)
AS
BEGIN
    DELETE FROM SavingsGoalProgress WHERE ProgressID = @ProgressID
END;

--DEBT TABLE
 
CREATE PROCEDURE CreateDebt (
    @DebtID INT,
    @UserID INT,
    @Creditor VARCHAR(255),
    @DebtAmount DECIMAL(10, 2),
    @InterestRate DECIMAL(5, 2),
    @MinimumPayment DECIMAL(10, 2),
    @PaymentDueDate DATE
)
AS
BEGIN
    INSERT INTO Debt (DebtID, UserID, Creditor, DebtAmount, InterestRate, MinimumPayment, PaymentDueDate)
    VALUES (@DebtID, @UserID, @Creditor, @DebtAmount, @InterestRate, @MinimumPayment, @PaymentDueDate)
END;

 
CREATE PROCEDURE GetDebtByID (
    @DebtID INT
)
AS
BEGIN
    SELECT * FROM Debt WHERE DebtID = @DebtID
END;

 
CREATE PROCEDURE UpdateDebt (
    @DebtID INT,
    @UserID INT,
    @Creditor VARCHAR(255),
    @DebtAmount DECIMAL(10, 2),
    @InterestRate DECIMAL(5, 2),
    @MinimumPayment DECIMAL(10, 2),
    @PaymentDueDate DATE
)
AS
BEGIN
    UPDATE Debt
    SET UserID = @UserID,
        Creditor = @Creditor,
        DebtAmount = @DebtAmount,
        InterestRate = @InterestRate,
        MinimumPayment = @MinimumPayment,
        PaymentDueDate = @PaymentDueDate
    WHERE DebtID = @DebtID
END;

 
CREATE PROCEDURE DeleteDebt (
    @DebtID INT
)
AS
BEGIN
    DELETE FROM Debt WHERE DebtID = @DebtID
END;

--INVESTMENT TABLE

 
CREATE PROCEDURE CreateInvestment (
    @InvestmentID INT,
    @UserID INT,
    @InvestmentName VARCHAR(255),
    @Description TEXT,
    @InvestmentAmount DECIMAL(10, 2),
    @InvestmentDate DATE
)
AS
BEGIN
    INSERT INTO Investment (InvestmentID, UserID, InvestmentName, Description, InvestmentAmount, InvestmentDate)
    VALUES (@InvestmentID, @UserID, @InvestmentName, @Description, @InvestmentAmount, @InvestmentDate)
END;

 
CREATE PROCEDURE GetInvestmentByID (
    @InvestmentID INT
)
AS
BEGIN
    SELECT * FROM Investment WHERE InvestmentID = @InvestmentID
END;

 
CREATE PROCEDURE UpdateInvestment (
    @InvestmentID INT,
    @UserID INT,
    @InvestmentName VARCHAR(255),
    @Description TEXT,
    @InvestmentAmount DECIMAL(10, 2),
    @InvestmentDate DATE
)
AS
BEGIN
    UPDATE Investment
    SET UserID = @UserID,
        InvestmentName = @InvestmentName,
        Description = @Description,
        InvestmentAmount = @InvestmentAmount,
        InvestmentDate = @InvestmentDate
    WHERE InvestmentID = @InvestmentID
END;
 
CREATE PROCEDURE DeleteInvestment (
    @InvestmentID INT
)
AS
BEGIN
    DELETE FROM Investment WHERE InvestmentID = @InvestmentID
END;

--ASSET TABLE

 
CREATE PROCEDURE CreateAsset (
    @AssetID INT,
    @UserID INT,
    @AssetName VARCHAR(255),
    @Description TEXT,
    @EstimatedValue DECIMAL(10, 2)
)
AS
BEGIN
    INSERT INTO Asset (AssetID, UserID, AssetName, Description, EstimatedValue)
    VALUES (@AssetID, @UserID, @AssetName, @Description, @EstimatedValue)
END;

 
CREATE PROCEDURE GetAssetByID (
    @AssetID INT
)
AS
BEGIN
    SELECT * FROM Asset WHERE AssetID = @AssetID
END;
 
CREATE PROCEDURE UpdateAsset (
    @AssetID INT,
    @UserID INT,
    @AssetName VARCHAR(255),
    @Description TEXT,
    @EstimatedValue DECIMAL(10, 2)
)
AS
BEGIN
    UPDATE Asset
    SET UserID = @UserID,
        AssetName = @AssetName,
        Description = @Description,
        EstimatedValue = @EstimatedValue
    WHERE AssetID = @AssetID
END;
 
CREATE PROCEDURE DeleteAsset (
    @AssetID INT
)
AS
BEGIN
    DELETE FROM Asset WHERE AssetID = @AssetID
END;




