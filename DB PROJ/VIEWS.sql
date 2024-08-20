create view TransactionByCategory
as
select u.Username as [User Name],t.Trans_Type as [Transaction Type],c.CategoryName as [Category],t.Date,t.Amount from trans t inner join Category c  on t.CategoryID=c.CategoryID inner join us u on u.UserID=t.UserID

create view DebtByUser
as
select u.Username as [User Name],d.Creditor,d.DebtAmount as [Debt Amount],d.InterestRate as [Interest Rate],d.MinimumPayment as [Minimum Payment],d.PaymentDueDate as [Due Date] from Debt d inner join us u on u.UserID=d.UserID 

create view InvestmentByUser
as
select u.Username as [User Name],i.InvestmentName as [Investment Name],i.Description,i.InvestmentAmount as [Investment Amount],i.InvestmentDate as [Date] from Investment i inner join us u on u.UserID=i.UserID 

create view Budget_By_Month_By_Category
as
select u.UserName as [User Name],c.CategoryName as [Category],b.BudgetAmount as [Budget Amount],b.Month,b.Year from Budget b inner join Category c on b.CategoryID=c.CategoryID inner join us u on u.UserID=b.UserID

create view AssetByUser
as
select u.Username as [User Name],a.AssetName as [Asset Name],a.Description,a.EstimatedValue as [Asset Value]  from Asset a inner join us u on u.UserID=a.UserID


select * from TransactionByCategory
select * from DebtByUser
select * from InvestmentByUser
select * from Budget_By_Month_By_Category
select * from AssetByUser
