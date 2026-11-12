-- =====================================================================
-- SQL & RELATIONAL DATABASE DESIGN - ASSIGNMENT SOLUTIONS
-- Student: Elvin Səfiyev
-- Group: 845İ
-- Database: SalesDB
-- =====================================================================

CREATE DATABASE IF NOT EXISTS SalesDB;
USE SalesDB;

-- =====================================================================
-- PART I — REQUIRED DATABASE SETUP
-- =====================================================================

-- 1. Table Structures to Create

-- Customers Table
CREATE TABLE IF NOT EXISTS Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Score INT
);

-- Products Table
CREATE TABLE IF NOT EXISTS Products (
    ProductID INT PRIMARY KEY,
    Product VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

-- Employees Table
CREATE TABLE IF NOT EXISTS Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    BirthDate DATE,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2) NOT NULL,
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- Orders Table
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL,
    SalesPersonID INT NOT NULL,
    OrderDate DATE NOT NULL,
    ShipDate DATE,
    OrderStatus VARCHAR(30) NOT NULL,
    ShipAddress VARCHAR(150),
    BillAddress VARCHAR(150),
    Quantity INT NOT NULL,
    Sales DECIMAL(10,2) NOT NULL,
    CreationTime DATETIME,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

-- 2. Sample Data Insertion

-- Sample records for Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Ayla', 'Karimova', 'Azerbaijan', 720),
(2, 'John', 'Miller', 'USA', 450),
(3, 'Emma', 'Schmidt', 'Germany', 860),
(4, 'Sara', 'Martin', 'France', 280),
(5, 'Lukas', 'Weber', 'Germany', 550);

-- Sample records for Products
INSERT INTO Products (ProductID, Product, Category, Price) VALUES
(101, 'Wireless Mouse', 'Electronics', 55.00),
(102, 'Office Chair', 'Furniture', 230.00),
(103, 'Laptop', 'Electronics', 850.00),
(104, 'Notebook', 'Stationery', 12.00),
(105, 'Smart Phone', 'Electronics', 420.00);

-- Sample records for Employees
INSERT INTO Employees (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID) VALUES
(11, 'David', 'Lee', 'Sales', '1988-04-12', 'Male', 2200.00, NULL),
(12, 'Maya', 'Brown', 'Sales', '1992-09-25', 'Female', 2400.00, 11),
(13, 'Alex', 'Green', 'Support', '1995-01-18', 'Male', 1900.00, 11);

-- Sample records for Orders (including business scenario test data)
INSERT INTO Orders (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate, OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime) VALUES
(201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', '12 Nizami Street, Baku', '12 Nizami Street, Baku', 2, 110.00, '2026-10-04 10:30:00'),
(202, 103, 3, 12, '2026-10-08', '2026-10-10', 'Shipped', 'Hauptstrasse 14, Berlin', 'Hauptstrasse 14, Berlin', 1, 850.00, '2026-10-08 14:15:00'),
(203, 102, 2, 11, '2026-10-12', NULL, 'Pending', '350 5th Avenue, New York', '350 5th Avenue, New York', 1, 230.00, '2026-10-12 09:00:00'),
(204, 105, 5, 12, '2026-10-15', '2026-10-26', 'Delivered', 'Marienplatz 8, Munich', 'Marienplatz 8, Munich', 1, 420.00, '2026-10-15 16:45:00'),
(105, 103, 3, 12, '2026-10-20', NULL, 'Pending', 'Hauptstrasse 14, Berlin', 'Hauptstrasse 14, Berlin', 2, 1700.00, '2026-10-20 12:00:00'),
(110, 101, 1, 11, '2026-10-22', NULL, 'Pending', 'Old Address 10', '12 Nizami Street, Baku', 1, 55.00, '2026-10-22 13:30:00'),
(205, 103, 3, 12, '2026-10-25', '2026-10-28', 'Shipped', 'Hauptstrasse 14, Berlin', 'Hauptstrasse 14, Berlin', 3, 2550.00, '2026-10-25 15:00:00'),
(999, 104, 2, 13, '2026-10-30', NULL, 'Pending', 'Test Address', 'Test Address', 1, 12.00, '2026-10-30 18:00:00');

-- =====================================================================
-- 4. TEN FOUNDATIONAL SQL EXERCISES
-- =====================================================================

-- Task 1 — Explore a table
-- Retrieve all columns from Customers, then retrieve only FirstName, LastName, and Country.
SELECT * FROM Customers;

SELECT FirstName, LastName, Country 
FROM Customers;

-- Task 2 — Filter by country
-- Display customers from Germany showing CustomerID, FirstName, LastName, and Country.
SELECT CustomerID, FirstName, LastName, Country 
FROM Customers 
WHERE Country = 'Germany';

-- Task 3 — Combine conditions
-- Find customers whose Score is at least 300 and who live in Germany or France.
SELECT CustomerID, FirstName, LastName, Country, Score 
FROM Customers 
WHERE Score >= 300 AND Country IN ('Germany', 'France');

-- Task 4 — Sort products
-- Display ProductID, Product, Category, and Price, sorted from most expensive to least expensive.
SELECT ProductID, Product, Category, Price 
FROM Products 
ORDER BY Price DESC;

-- Task 5 — Search within a range
-- List products costing between 50 and 300 (inclusive), showing Product and Price.
SELECT Product, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 300;

-- Task 6 — Search text patterns
-- Find products whose Product name contains the word 'Phone'.
SELECT Product, Category 
FROM Products 
WHERE Product LIKE '%Phone%';

-- Task 7 — Find distinct values
-- Show each unique product Category once, in alphabetical order.
SELECT DISTINCT Category 
FROM Products 
ORDER BY Category ASC;

-- Task 8 — Connect customer orders
-- Display each OrderID alongside the first and last name of its customer.
SELECT Orders.OrderID, Customers.FirstName, Customers.LastName 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Task 9 — Summarize orders
-- Calculate the number of orders and total Sales for each OrderStatus; sort by total Sales descending.
SELECT OrderStatus, 
       COUNT(OrderID) AS NumberOfOrders, 
       SUM(Sales) AS TotalSales 
FROM Orders 
GROUP BY OrderStatus 
ORDER BY TotalSales DESC;

-- Task 10 — Make a safe data change
-- Insert a new product, update its price, verify, then delete it.
-- Explanation: UPDATE and DELETE statements always require a WHERE clause to target specific records.
-- Without a WHERE clause, an UPDATE will alter every single row, and a DELETE will wipe the entire table.

INSERT INTO Products (ProductID, Product, Category, Price) 
VALUES (901, 'Smart Watch', 'Electronics', 150.00);

UPDATE Products 
SET Price = 180.00 
WHERE ProductID = 901;

SELECT * FROM Products WHERE ProductID = 901;

DELETE FROM Products 
WHERE ProductID = 901;


-- =====================================================================
-- PART II — SALESDB BUSINESS SCENARIOS
-- =====================================================================

-- ---------------------------------------------------------------------
-- ASSIGNMENT 1 — CUSTOMER LOYALTY AND SALES ANALYSIS
-- ---------------------------------------------------------------------

-- Assignment 1, Task 1: High-score customers
-- Find customers with Score greater than 500, sorted by Score descending.
SELECT FirstName, LastName, Country, Score 
FROM Customers 
WHERE Score > 500 
ORDER BY Score DESC;

-- Assignment 1, Task 2: Target countries
-- Select customers from Germany, France or USA whose Score is at least 300.
SELECT FirstName, LastName, Country, Score 
FROM Customers 
WHERE Country IN ('Germany', 'France', 'USA') AND Score >= 300;

-- Assignment 1, Task 3: Purchase history
-- Show each existing order with the customer's full name, OrderID, OrderDate, and Sales.
SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Orders.OrderID, 
       Orders.OrderDate, 
       Orders.Sales 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;

-- Assignment 1, Task 4: Inactive customers
-- Find all customers who have never placed an order using LEFT JOIN.
SELECT Customers.CustomerID, 
       Customers.FirstName, 
       Customers.LastName, 
       Customers.Country 
FROM Customers 
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
WHERE Orders.OrderID IS NULL;

-- Assignment 1, Task 5: Total customer spending
-- Calculate total Sales for each customer with at least one order and sort highest to lowest.
SELECT Customers.CustomerID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName 
ORDER BY TotalSales DESC;

-- Assignment 1, Task 6: Loyalty threshold
-- Display only customers whose total Sales is greater than 1,000.
SELECT Customers.CustomerID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName 
HAVING SUM(Orders.Sales) > 1000;

-- Assignment 1, Task 7: Top-five report
-- Display the five customers with the highest total Sales, including full name, Country, and total spending.
SELECT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Customers.Country, 
       SUM(Orders.Sales) AS TotalSales 
FROM Customers 
INNER JOIN Orders ON Customers.CustomerID = Orders.CustomerID 
GROUP BY Customers.CustomerID, Customers.FirstName, Customers.LastName, Customers.Country 
ORDER BY TotalSales DESC 
LIMIT 5;


-- ---------------------------------------------------------------------
-- ASSIGNMENT 2 — ORDER AND DELIVERY INVESTIGATION
-- ---------------------------------------------------------------------

-- Assignment 2, Task 1: October orders
-- List orders placed from 2026-10-01 through 2026-10-31 (inclusive).
SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus 
FROM Orders 
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31';

-- Assignment 2, Task 2: Pending queue
-- Find orders with OrderStatus = 'Pending' and sort by oldest OrderDate first.
SELECT * 
FROM Orders 
WHERE OrderStatus = 'Pending' 
ORDER BY OrderDate ASC;

-- Assignment 2, Task 3: Late shipments
-- Find orders where ShipDate is more than 7 days after OrderDate.
SELECT Orders.OrderID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Orders.OrderDate, 
       Orders.ShipDate 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE DATEDIFF(Orders.ShipDate, Orders.OrderDate) > 7;

-- Assignment 2, Task 4: Affected customers
-- List customer names and countries associated with delayed orders from Task 3.
SELECT DISTINCT CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Customers.Country 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE DATEDIFF(Orders.ShipDate, Orders.OrderDate) > 7;

-- Assignment 2, Task 5: Status correction
-- Preview and update OrderID 105: set OrderStatus to 'Shipped' and ShipDate to '2026-11-05'.
SELECT * FROM Orders WHERE OrderID = 105;

UPDATE Orders 
SET OrderStatus = 'Shipped', 
    ShipDate = '2026-11-05' 
WHERE OrderID = 105;

-- Assignment 2, Task 6: Address correction
-- Preview and update OrderID 110: set ShipAddress to '45 Main Street, Baku'.
SELECT * FROM Orders WHERE OrderID = 110;

UPDATE Orders 
SET ShipAddress = '45 Main Street, Baku' 
WHERE OrderID = 110;

-- Assignment 2, Task 7: Remove test data
-- Preview and delete test OrderID 999.
SELECT * FROM Orders WHERE OrderID = 999;

DELETE FROM Orders 
WHERE OrderID = 999;

-- Assignment 2, Task 8: Status distribution
-- Count orders in each OrderStatus.
SELECT OrderStatus, COUNT(OrderID) AS OrderCount 
FROM Orders 
GROUP BY OrderStatus;

-- Assignment 2, Task 9: Unshipped orders
-- List orders for which ShipDate is NULL.
SELECT Orders.OrderID, 
       CONCAT(Customers.FirstName, ' ', Customers.LastName) AS CustomerName, 
       Orders.OrderDate, 
       Orders.OrderStatus 
FROM Orders 
INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID 
WHERE Orders.ShipDate IS NULL;


-- ---------------------------------------------------------------------
-- ASSIGNMENT 3 — PRODUCTS AND EMPLOYEE PERFORMANCE
-- ---------------------------------------------------------------------

-- Assignment 3, Task 1: Affordable products
-- Find products priced between 50 and 300 (inclusive) in ascending price order.
SELECT Product, Category, Price 
FROM Products 
WHERE Price BETWEEN 50 AND 300 
ORDER BY Price ASC;

-- Assignment 3, Task 2: Premium electronics
-- Find Electronics products whose Price is greater than 500.
SELECT ProductID, Product, Category, Price 
FROM Products 
WHERE Category = 'Electronics' AND Price > 500;

-- Assignment 3, Task 3: Product sales
-- Join Products and Orders to show product name, category, order Quantity, and Sales.
SELECT Products.Product, 
       Products.Category, 
       Orders.Quantity, 
       Orders.Sales 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID;

-- Assignment 3, Task 4: Best-selling products
-- Calculate total Quantity for each product and return the top five.
SELECT Products.ProductID, 
       Products.Product, 
       SUM(Orders.Quantity) AS TotalQuantity 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID 
GROUP BY Products.ProductID, Products.Product 
ORDER BY TotalQuantity DESC 
LIMIT 5;

-- Assignment 3, Task 5: Unsold items
-- Find products that have no matching record in Orders.
SELECT Products.ProductID, 
       Products.Product, 
       Products.Category, 
       Products.Price 
FROM Products 
LEFT JOIN Orders ON Products.ProductID = Orders.ProductID 
WHERE Orders.OrderID IS NULL;

-- Assignment 3, Task 6: Employee performance
-- Join Employees and Orders: show employee full name, Department, and total Sales.
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS EmployeeName, 
       Employees.Department, 
       SUM(Orders.Sales) AS TotalSales 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID = Orders.SalesPersonID 
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName, Employees.Department;

-- Assignment 3, Task 7: Top-performing staff
-- List employees whose total Sales exceeds 5,000, sorted highest first.
SELECT CONCAT(Employees.FirstName, ' ', Employees.LastName) AS EmployeeName, 
       SUM(Orders.Sales) AS TotalSales 
FROM Employees 
INNER JOIN Orders ON Employees.EmployeeID = Orders.SalesPersonID 
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName 
HAVING SUM(Orders.Sales) > 5000 
ORDER BY TotalSales DESC;

-- Assignment 3, Task 8: New product
-- Insert ProductID 501 (Wireless Keyboard, Electronics, 75.00).
INSERT INTO Products (ProductID, Product, Category, Price) 
VALUES (501, 'Wireless Keyboard', 'Electronics', 75.00);

-- Assignment 3, Task 9: Price correction
-- Change price of ProductID 501 from 75 to 90.
UPDATE Products 
SET Price = 90.00 
WHERE ProductID = 501;

-- Assignment 3, Task 10: Inventory column
-- Add StockQuantity column to Products using ALTER TABLE.
ALTER TABLE Products 
ADD StockQuantity INT;

-- Assignment 3, Task 11: Combined directory
-- Produce a unique list of FirstName and LastName from Customers and Employees using UNION.
SELECT FirstName, LastName FROM Customers 
UNION 
SELECT FirstName, LastName FROM Employees;

-- Assignment 3, Task 12: Category performance
-- Total Quantity and total Sales for categories with Sales above 2,000, sorted highest first.
SELECT Products.Category, 
       SUM(Orders.Quantity) AS TotalQuantity, 
       SUM(Orders.Sales) AS TotalSales 
FROM Products 
INNER JOIN Orders ON Products.ProductID = Orders.ProductID 
GROUP BY Products.Category 
HAVING SUM(Orders.Sales) > 2000 
ORDER BY TotalSales DESC;


-- =====================================================================
-- PART III — UNIVERSITY COURSE REGISTRATION DDL (SCHEMA DEFINITION)
-- =====================================================================

CREATE TABLE IF NOT EXISTS Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100),
    BirthDate DATE,
    Faculty VARCHAR(100),
    EnrollmentYear INT
);

CREATE TABLE IF NOT EXISTS Instructors (
    InstructorID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(100),
    Email VARCHAR(100),
    Salary DECIMAL(10,2) NOT NULL
);

CREATE TABLE IF NOT EXISTS Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    Credits INT NOT NULL,
    Semester VARCHAR(20),
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE IF NOT EXISTS Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT NOT NULL,
    CourseID INT NOT NULL,
    EnrollmentDate DATE NOT NULL,
    Grade DECIMAL(5,2),
    Status VARCHAR(20),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE (StudentID, CourseID)
);
