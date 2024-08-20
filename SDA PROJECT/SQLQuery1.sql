select * from INC
select * from EXPEN
select * from INC_Categories
select * from EXP_Categories

INSERT INTO INC (Name, Amount, Category, Date, Description, IncUser) VALUES
('Salary', 50000, 'Salary', '2024-02-01', 'Monthly salary', 'fahad'),
('Freelancing', 15000, 'Freelance', '2024-03-05', 'Freelance project', 'fahad'),
('Investment', 8000, 'Investment', '2024-04-10', 'Stock dividends', 'fahad'),
('Gift', 2000, 'Gift', '2024-05-15', 'Birthday gift', 'fahad'),
('Bonus', 10000, 'Bonus', '2024-06-20', 'Quarterly bonus', 'fahad'),
('Salary', 50000, 'Salary', '2024-03-01', 'Monthly salary', 'fahad'),
('Freelancing', 12000, 'Freelance', '2024-04-05', 'Freelance project', 'fahad'),
('Investment', 9000, 'Investment', '2024-05-10', 'Stock dividends', 'fahad'),
('Gift', 2500, 'Gift', '2024-06-15', 'Birthday gift', 'fahad'),
('Bonus', 11000, 'Bonus', '2024-02-20', 'Quarterly bonus', 'fahad'),
('Salary', 50000, 'Salary', '2024-04-01', 'Monthly salary', 'fahad'),
('Freelancing', 13000, 'Freelance', '2024-05-05', 'Freelance project', 'fahad'),
('Investment', 7000, 'Investment', '2024-06-10', 'Stock dividends', 'fahad'),
('Gift', 3000, 'Gift', '2024-02-15', 'Birthday gift', 'fahad'),
('Bonus', 12000, 'Bonus', '2024-03-20', 'Quarterly bonus', 'fahad');

INSERT INTO EXPEN (Name, Amount, Category, Date, Description, ExpUser) VALUES
('Groceries', 5000, 'Food', '2024-02-02', 'Monthly groceries', 'fahad'),
('Rent', 15000, 'Housing', '2024-03-03', 'Monthly rent', 'fahad'),
('Utilities', 3000, 'Bills', '2024-04-04', 'Electricity and water', 'fahad'),
('Internet', 1000, 'Bills', '2024-05-05', 'Monthly internet bill', 'fahad'),
('Dining Out', 2000, 'Entertainment', '2024-06-06', 'Dinner with friends', 'fahad'),
('Transport', 3000, 'Travel', '2024-03-07', 'Monthly transport', 'fahad'),
('Clothing', 4000, 'Shopping', '2024-04-08', 'New clothes', 'fahad'),
('Gym', 2000, 'Health', '2024-05-09', 'Gym membership', 'fahad'),
('Insurance', 5000, 'Insurance', '2024-06-10', 'Health insurance', 'fahad'),
('Vacation', 10000, 'Travel', '2024-02-11', 'Weekend trip', 'fahad'),
('Groceries', 6000, 'Food', '2024-03-02', 'Monthly groceries', 'fahad'),
('Rent', 16000, 'Housing', '2024-04-03', 'Monthly rent', 'fahad'),
('Utilities', 3500, 'Bills', '2024-05-04', 'Electricity and water', 'fahad'),
('Internet', 1200, 'Bills', '2024-06-05', 'Monthly internet bill', 'fahad'),
('Dining Out', 2500, 'Entertainment', '2024-02-06', 'Dinner with friends', 'fahad'),
('Transport', 3500, 'Travel', '2024-03-07', 'Monthly transport', 'fahad'),
('Clothing', 4500, 'Shopping', '2024-04-08', 'New clothes', 'fahad'),
('Gym', 2500, 'Health', '2024-05-09', 'Gym membership', 'fahad'),
('Insurance', 5500, 'Insurance', '2024-06-10', 'Health insurance', 'fahad'),
('Vacation', 11000, 'Travel', '2024-02-11', 'Weekend trip', 'fahad');

INSERT INTO INC (Name, Amount, Category, Date, Description, IncUser) VALUES
('Salary', 55000, 'Salary', '2024-02-01', 'Monthly salary', 'Ali'),
('Freelancing', 14000, 'Freelance', '2024-03-05', 'Freelance project', 'Ali'),
('Investment', 7000, 'Investment', '2024-04-10', 'Stock dividends', 'Ali'),
('Gift', 1500, 'Gift', '2024-05-15', 'Birthday gift', 'Ali'),
('Bonus', 9000, 'Bonus', '2024-06-20', 'Quarterly bonus', 'Ali'),
('Salary', 55000, 'Salary', '2024-03-01', 'Monthly salary', 'Ali'),
('Freelancing', 11000, 'Freelance', '2024-04-05', 'Freelance project', 'Ali'),
('Investment', 8000, 'Investment', '2024-05-10', 'Stock dividends', 'Ali'),
('Gift', 2000, 'Gift', '2024-06-15', 'Birthday gift', 'Ali'),
('Bonus', 10000, 'Bonus', '2024-02-20', 'Quarterly bonus', 'Ali'),
('Salary', 55000, 'Salary', '2024-04-01', 'Monthly salary', 'Ali'),
('Freelancing', 12000, 'Freelance', '2024-05-05', 'Freelance project', 'Ali'),
('Investment', 6000, 'Investment', '2024-06-10', 'Stock dividends', 'Ali'),
('Gift', 2500, 'Gift', '2024-02-15', 'Birthday gift', 'Ali'),
('Bonus', 11000, 'Bonus', '2024-03-20', 'Quarterly bonus', 'Ali');

INSERT INTO EXPEN (Name, Amount, Category, Date, Description, ExpUser) VALUES
('Groceries', 4500, 'Food', '2024-02-02', 'Monthly groceries', 'Ali'),
('Rent', 14000, 'Housing', '2024-03-03', 'Monthly rent', 'Ali'),
('Utilities', 2500, 'Bills', '2024-04-04', 'Electricity and water', 'Ali'),
('Internet', 900, 'Bills', '2024-05-05', 'Monthly internet bill', 'Ali'),
('Dining Out', 1500, 'Entertainment', '2024-06-06', 'Dinner with friends', 'Ali'),
('Transport', 2500, 'Travel', '2024-03-07', 'Monthly transport', 'Ali'),
('Clothing', 3500, 'Shopping', '2024-04-08', 'New clothes', 'Ali'),
('Gym', 1500, 'Health', '2024-05-09', 'Gym membership', 'Ali'),
('Insurance', 4500, 'Insurance', '2024-06-10', 'Health insurance', 'Ali'),
('Vacation', 9000, 'Travel', '2024-02-11', 'Weekend trip', 'Ali'),
('Groceries', 5000, 'Food', '2024-03-02', 'Monthly groceries', 'Ali'),
('Rent', 12000, 'Housing', '2024-04-03', 'Monthly rent', 'Ali'),
('Utilities', 3000, 'Bills', '2024-05-04', 'Electricity and water', 'Ali'),
('Internet', 1000, 'Bills', '2024-06-05', 'Monthly internet bill', 'Ali'),
('Dining Out', 2000, 'Entertainment', '2024-02-06', 'Dinner with friends', 'Ali'),
('Transport', 3000, 'Travel', '2024-03-07', 'Monthly transport', 'Ali'),
('Clothing', 4000, 'Shopping', '2024-04-08', 'New clothes', 'Ali'),
('Gym', 2000, 'Health', '2024-05-09', 'Gym membership', 'Ali'),
('Insurance', 5000, 'Insurance', '2024-06-10', 'Health insurance', 'Ali'),
('Vacation', 10000, 'Travel', '2024-02-11', 'Weekend trip', 'Ali');

INSERT INTO INC_Categories (Category) VALUES
('Salary'),
('Freelance'),
('Investment'),
('Gift'),
('Bonus');


INSERT INTO EXP_Categories (Category) VALUES
('Food'),
('Housing'),
('Bills'),
('Entertainment'),
('Travel'),
('Shopping'),
('Health'),
('Insurance');

