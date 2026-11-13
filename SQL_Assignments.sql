-- SQL Assignments
-- Elvin Səfiyev - Group 845İ

-- ====================================================
-- PART 1: Database Setup
-- ====================================================

CREATE DATABASE IF NOT EXISTS SalesDB;
USE SalesDB;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Country VARCHAR(50),
    Score INT
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    BirthDate DATE,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT,
    CustomerID INT,
    SalesPersonID INT,
    OrderDate DATE,
    ShipDate DATE,
    OrderStatus VARCHAR(30),
    ShipAddress VARCHAR(150),
    BillAddress VARCHAR(150),
    Quantity INT,
    Sales DECIMAL(10,2),
    CreationTime DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

-- Sample data
INSERT INTO Customers VALUES
(1, 'Ayla', 'Karimova', 'Azerbaijan', 720),
(2, 'John', 'Miller', 'USA', 450),
(3, 'Emma', 'Schmidt', 'Germany', 860),
(4, 'Sara', 'Martin', 'France', 280),
(5, 'Lukas', 'Weber', 'Germany', 550);

INSERT INTO Products VALUES
(101, 'Wireless Mouse', 'Electronics', 55.00),
(102, 'Office Chair', 'Furniture', 230.00),
(103, 'Laptop', 'Electronics', 850.00),
(104, 'Notebook', 'Stationery', 12.00),
(105, 'Smart Phone', 'Electronics', 420.00);

INSERT INTO Employees VALUES
(11, 'David', 'Lee', 'Sales', '1988-04-12', 'Male', 2200.00, NULL),
(12, 'Maya', 'Brown', 'Sales', '1992-09-25', 'Female', 2400.00, 11),
(13, 'Alex', 'Green', 'Support', '1995-01-18', 'Male', 1900.00, 11);

INSERT INTO Orders VALUES
(201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', '12 Nizami Street, Baku', '12 Nizami Street, Baku', 2, 110.00, '2026-10-04 10:30:00'),
(202, 103, 3, 12, '2026-10-08', '2026-10-10', 'Shipped', 'Hauptstrasse 14, Berlin', 'Hauptstrasse 14, Berlin', 1, 850.00, '2026-10-08 14:15:00'),
(203, 102, 2, 11, '2026-10-12', NULL, 'Pending', '350 5th Avenue, New York', '350 5th Avenue, New York', 1, 230.00, '2026-10-12 09:00:00'),
(204, 105, 5, 12, '2026-10-15', '2026-10-26', 'Delivered', 'Marienplatz 8, Munich', 'Marienplatz 8, Munich', 1, 420.00, '2026-10-15 16:45:00'),
(105, 103, 3, 12, '2026-10-20', NULL, 'Pending', 'Hauptstrasse 14, Berlin', 'Hauptstrasse 14, Berlin', 2, 1700.00, '2026-10-20 12:00:00'),
(110, 101, 1, 11, '2026-10-22', NULL, 'Pending', 'Old Address 10', '12 Nizami Street, Baku', 1, 55.00, '2026-10-22 13:30:00'),
(205, 103, 3, 12, '2026-10-25', '2026-10-28', 'Shipped', 'Hauptstrasse 14, Berlin', 'Hauptstrasse 14, Berlin', 3, 2550.00, '2026-10-25 15:00:00'),
(999, 104, 2, 13, '2026-10-30', NULL, 'Pending', 'Test Address', 'Test Address', 1, 12.00, '2026-10-30 18:00:00');

-- ====================================================
-- Ten Foundational SQL Exercises (Tasks 1-10)
-- ====================================================

-- Task 1: Explore a table
SELECT * FROM Customers;

SELECT FirstName, LastName, Country 
FROM Customers;

-- Task 2: Filter by country
SELECT CustomerID, FirstName, LastName, Country 
FROM Customers 
WHERE Country = 'Germany';

-- Task 3: Combine conditions
SELECT CustomerID, FirstName, LastName, Country, Score 
FROM Customers 
WHERE Score >= 300 AND Country IN ('Germany', 'France');

-- Task 4: Sort products
SELECT ProductID, Product, Category, Price 
FROM Products 
ORDER BY Price DESC;

-- Task 5: Search within a range
SELECT Product, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 300;

-- Task 6: Search text patterns
SELECT Product, Category 
FROM Products 
WHERE Product LIKE '%Phone%';

-- Task 7: Find distinct values
SELECT DISTINCT Category 
FROM Products 
ORDER BY Category ASC;

-- Task 8: Connect customer orders
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Task 9: Summarize orders
SELECT OrderStatus, COUNT(OrderID) AS NumberOfOrders, SUM(Sales) AS TotalSales 
FROM Orders 
GROUP BY OrderStatus 
ORDER BY TotalSales DESC;

-- Task 10: Make a safe data change
INSERT INTO Products (ProductID, Product, Category, Price) 
VALUES (901, 'Smart Watch', 'Electronics', 150.00);

UPDATE Products 
SET Price = 180.00 
WHERE ProductID = 901;

SELECT * FROM Products WHERE ProductID = 901;

DELETE FROM Products 
WHERE ProductID = 901;

-- UPDATE and DELETE need a WHERE clause so they do not modify or delete all rows in the table.


-- ====================================================
-- Assignment 1: Customer Loyalty and Sales Analysis
-- ====================================================

-- Task 1: High-score customers
SELECT FirstName, LastName, Country, Score 
FROM Customers 
WHERE Score > 500 
ORDER BY Score DESC;

-- Task 2: Target countries
SELECT FirstName, LastName, Country, Score 
FROM Customers 
WHERE Country IN ('Germany', 'France', 'USA') AND Score >= 300;

-- Task 3: Purchase history
SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Orders.OrderID, Orders.OrderDate, Orders.Sales 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Task 4: Inactive customers
SELECT Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Country 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Orders.OrderID IS NULL;

-- Task 5: Total customer spending
SELECT Customers.CustomerID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName 
ORDER BY TotalSales DESC;

-- Task 6: Loyalty threshold
SELECT Customers.CustomerID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName 
HAVING SUM(Orders.Sales) > 1000;

-- Task 7: Top-five report
SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Customers.Country, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Country 
ORDER BY TotalSales DESC 
LIMIT 5;


-- ====================================================
-- Assignment 2: Order and Delivery Investigation
-- ====================================================

-- Task 1: October orders
SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus 
FROM Orders 
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31';

-- Task 2: Pending queue
SELECT * FROM Orders 
WHERE OrderStatus = 'Pending' 
ORDER BY OrderDate ASC;

-- Task 3: Late shipments
SELECT Orders.OrderID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Orders.OrderDate, Orders.ShipDate 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE DATEDIFF(Orders.ShipDate, Orders.OrderDate) > 7;

-- Task 4: Affected customers
SELECT DISTINCT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Customers.Country 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE DATEDIFF(Orders.ShipDate, Orders.OrderDate) > 7;

-- Task 5: Status correction
UPDATE Orders 
SET OrderStatus = 'Shipped', ShipDate = '2026-11-05' 
WHERE OrderID = 105;

-- Task 6: Address correction
UPDATE Orders 
SET ShipAddress = '45 Main Street, Baku' 
WHERE OrderID = 110;

-- Task 7: Remove test data
DELETE FROM Orders 
WHERE OrderID = 999;

-- Task 8: Status distribution
SELECT OrderStatus, COUNT(OrderID) AS OrderCount 
FROM Orders 
GROUP BY OrderStatus;

-- Task 9: Unshipped orders
SELECT Orders.OrderID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Orders.OrderDate, Orders.OrderStatus 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE Orders.ShipDate IS NULL;


-- ====================================================
-- Assignment 3: Products and Employee Performance
-- ====================================================

-- Task 1: Affordable products
SELECT Product, Category, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 300 
ORDER BY Price ASC;

-- Task 2: Premium electronics
SELECT ProductID, Product, Category, Price 
FROM Products 
WHERE Category = 'Electronics' AND Price > 500;

-- Task 3: Product sales
SELECT Products.Product, Products.Category, Orders.Quantity, Orders.Sales 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID;

-- Task 4: Best-selling products
SELECT Products.ProductID, Products.Product, SUM(Orders.Quantity) AS TotalQuantity 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID 
GROUP BY Products.ProductID, Products.Product 
ORDER BY TotalQuantity DESC 
LIMIT 5;

-- Task 5: Unsold items
SELECT Products.ProductID, Products.Product, Products.Category, Products.Price 
FROM Products 
LEFT JOIN Orders ON Products.ProductID = Orders.ProductID 
WHERE Orders.OrderID IS NULL;

-- Task 6: Employee performance
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS EmployeeName, 
       Employees.Department, SUM(Orders.Sales) AS TotalSales 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID = Orders.SalesPersonID 
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Department;

-- Task 7: Top-performing staff
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS EmployeeName, 
       SUM(Orders.Sales) AS TotalSales 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID = Orders.SalesPersonID 
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName 
HAVING SUM(Orders.Sales) > 5000 
ORDER BY TotalSales DESC;

-- Task 8: New product
INSERT INTO Products (ProductID, Product, Category, Price) 
VALUES (501, 'Wireless Keyboard', 'Electronics', 75.00);

-- Task 9: Price correction
UPDATE Products 
SET Price = 90.00 
WHERE ProductID = 501;

-- Task 10: Inventory column
ALTER TABLE Products 
ADD StockQuantity INT;

-- Task 11: Combined directory
SELECT FirstName, LastName FROM Customers 
UNION 
SELECT FirstName, LastName FROM Employees;

-- Task 12: Category performance
SELECT Products.Category, SUM(Orders.Quantity) AS TotalQuantity, SUM(Orders.Sales) AS TotalSales 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID 
GROUP BY Products.Category 
HAVING SUM(Orders.Sales) > 2000 
ORDER BY TotalSales DESC;


-- ====================================================
-- Assignment 5: Course Registration Tables (Bonus)
-- ====================================================

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    BirthDate DATE,
    Faculty VARCHAR(100),
    EnrollmentYear INT
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(100),
    Email VARCHAR(100),
    Salary DECIMAL(10,2)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    Semester VARCHAR(20),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade DECIMAL(5,2),
    Status VARCHAR(20),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE (StudentID, CourseID)
);
