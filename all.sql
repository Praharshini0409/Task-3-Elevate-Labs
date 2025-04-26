-- 1. Create the Orders Table
CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    CustomerName TEXT,
    Country TEXT,
    ProductName TEXT,
    Quantity INTEGER,
    Price REAL,
    OrderDate TEXT
);

-- Insert Sample Data into Orders Table
INSERT INTO Orders (OrderID, CustomerName, Country, ProductName, Quantity, Price, OrderDate)
VALUES
(1, 'Alice', 'USA', 'Laptop', 1, 1200.00, '2025-04-01'),
(2, 'Bob', 'India', 'Smartphone', 2, 800.00, '2025-04-02'),
(3, 'Charlie', 'Germany', 'Headphones', 3, 150.00, '2025-04-03'),
(4, 'David', 'USA', 'Smartwatch', 1, 250.00, '2025-04-04'),
(5, 'Eva', 'India', 'Tablet', 2, 600.00, '2025-04-05'),
(6, 'Frank', 'France', 'Camera', 1, 900.00, '2025-04-06'),
(7, 'Grace', 'USA', 'Smartphone', 1, 750.00, '2025-04-07'),
(8, 'Hannah', 'Germany', 'Tablet', 3, 650.00, '2025-04-08'),
(9, 'Isaac', 'France', 'Laptop', 2, 1100.00, '2025-04-09'),
(10, 'Jack', 'India', 'Headphones', 1, 140.00, '2025-04-10');

-- 2. Create the Customers Table
CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    Name TEXT,
    City TEXT,
    Country TEXT
);

-- Insert Sample Data into Customers Table
INSERT INTO Customers (CustomerID, Name, City, Country)
VALUES
(1, 'Alice', 'New York', 'USA'),
(2, 'Bob', 'Mumbai', 'India'),
(3, 'Charlie', 'Berlin', 'Germany'),
(4, 'David', 'Los Angeles', 'USA'),
(5, 'Eva', 'Delhi', 'India'),
(6, 'Frank', 'Paris', 'France');

-- 3. Queries

-- a. Use SELECT, WHERE, ORDER BY, GROUP BY
SELECT Country, COUNT(OrderID) AS TotalOrders
FROM Orders
WHERE Quantity > 1
GROUP BY Country
ORDER BY TotalOrders DESC;

-- b. Use JOINS (INNER, LEFT, RIGHT)

-- INNER JOIN: Retrieve orders with customer city
SELECT Orders.OrderID, Orders.CustomerName, Orders.ProductName, Customers.City
FROM Orders
INNER JOIN Customers ON Orders.CustomerName = Customers.Name;

-- LEFT JOIN: Retrieve all orders, including those with no matching customer data
SELECT Orders.OrderID, Orders.CustomerName, Orders.ProductName, Customers.City
FROM Orders
LEFT JOIN Customers ON Orders.CustomerName = Customers.Name;

-- RIGHT JOIN: Retrieve all customers, even those with no orders
SELECT Orders.OrderID, Orders.CustomerName, Orders.ProductName, Customers.City
FROM Orders
RIGHT JOIN Customers ON Orders.CustomerName = Customers.Name;

-- c. Write Subqueries
-- Subquery to find customers who ordered more than the average quantity of 'Smartphone'
SELECT CustomerName
FROM Orders
WHERE ProductName = 'Smartphone'
AND Quantity > (
    SELECT AVG(Quantity)
    FROM Orders
    WHERE ProductName = 'Smartphone'
);

-- d. Use Aggregate Functions (SUM, AVG)

-- SUM: Calculate the total sales per product
SELECT ProductName, SUM(Quantity * Price) AS TotalSales
FROM Orders
GROUP BY ProductName;

-- AVG: Calculate the average price of all orders
SELECT AVG(Price) AS AveragePrice
FROM Orders;

-- e. Create Views for Analysis

-- Create a view that summarizes orders by customer and country
CREATE VIEW CustomerOrderSummary AS
SELECT CustomerName, Country, COUNT(OrderID) AS OrderCount, SUM(Quantity * Price) AS TotalSpent
FROM Orders
GROUP BY CustomerName, Country;

-- Query the view
SELECT * FROM CustomerOrderSummary;

-- f. Optimize Queries with Indexes

-- Index for CustomerName to speed up queries involving customer name
CREATE INDEX idx_customer_name ON Orders(CustomerName);

-- Composite Index on Country and ProductName for optimization
CREATE INDEX idx_country_product ON Orders(Country, ProductName);

-- Query to test the CustomerName Index
SELECT * FROM Orders WHERE CustomerName = 'Alice';

-- Query to test the Composite Index (Country and ProductName)
SELECT * FROM Orders WHERE Country = 'USA' AND ProductName = 'Laptop';
