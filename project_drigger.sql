-- Create database
CREATE DATABASE sample;

-- Use the database
USE sample;

-- =========================================
-- CUSTOMERS TABLE
-- =========================================

-- Create customers table
CREATE TABLE customers(
    customerID INT PRIMARY KEY NOT NULL,
    name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    address VARCHAR(100)
);

-- Insert sample customer data
INSERT INTO customers (customerID, name, email, address) VALUES
(1, 'Amit Sharma', 'amit.sharma@gmail.com', 'Mumbai, Maharashtra'),
(2, 'Priya Patel', 'priya.patel@gmail.com', 'Surat, Gujarat'),
(3, 'Rahul Verma', 'rahul.verma@gmail.com', 'Delhi, India'),
(4, 'Sneha Reddy', 'sneha.reddy@gmail.com', 'Hyderabad, Telangana'),
(5, 'Arjun Singh', 'arjun.singh@gmail.com', 'Jaipur, Rajasthan');

-- View all customers
SELECT * FROM customers;

-- Update address of a customer
UPDATE customers 
SET address = 'Ahmedabad, Gujarat' 
WHERE customerID = 4;

-- Delete a customer
DELETE FROM customers 
WHERE customerID = 5;

-- Select customer by name (no result expected for Alice)
SELECT * FROM customers 
WHERE name = 'Alice';

-- =========================================
-- ORDERS TABLE
-- =========================================

-- Create orders table
CREATE TABLE orders(
    orderid INT PRIMARY KEY NOT NULL,
    customerid INT,
    order_date DATE,
    total_amount DECIMAL(10,3)
);

-- Insert sample orders
INSERT INTO orders (orderid, customerid, order_date, total_amount) VALUES
(101, 1, '2026-03-01', 1500.500),
(102, 2, '2026-03-05', 2300.750),
(103, 3, '2026-03-10', 999.999),
(104, 4, '2026-03-15', 1750.250),
(105, 5, '2026-03-20', 3200.000);

-- View orders for a specific customer
SELECT * FROM orders 
WHERE customerid = 2;

-- View all orders
SELECT * FROM orders;

-- Update order amount
UPDATE orders
SET total_amount = 5000
WHERE orderid = 104;

-- Delete an order
DELETE FROM orders 
WHERE orderid = 101;

-- Get orders from last 30 days
SELECT * FROM orders
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;

-- Aggregate functions on orders
SELECT 
    MAX(total_amount) AS highest_order_am,
    MIN(total_amount) AS lowest_order_am,
    AVG(total_amount) AS average_order_amo 
FROM orders;

-- =========================================
-- PRODUCTS TABLE
-- =========================================

-- Create products table
CREATE TABLE products(
    productID INT PRIMARY KEY NOT NULL,
    product_name VARCHAR(20),
    price DECIMAL(10,2),
    stock INT
);

-- Insert sample products
INSERT INTO products (productID, product_name, price, stock) VALUES
(201, 'Laptop', 55000.00, 10),
(202, 'Smartphone', 20000.50, 25),
(203, 'Headphones', 1500.75, 50),
(204, 'Keyboard', 800.00, 30),
(205, 'Mouse', 500.25, 40);

-- View products sorted by price (descending)
SELECT * FROM products 
ORDER BY price DESC;

-- Update product price
UPDATE products 
SET price = 7369.36 
WHERE productID = 203;

-- Delete products with negative stock (safe mode may block this)
DELETE FROM products 
WHERE stock < 0;

-- Get products within a price range
SELECT * FROM products 
WHERE price BETWEEN 500 AND 2000;

-- Find cheapest product
SELECT product_name 
FROM products 
WHERE price = (SELECT MIN(price) FROM products);

-- =========================================
-- ORDER DETAILS TABLE
-- =========================================

-- Create order details table with foreign keys
CREATE TABLE orders_detail (
    detailid INT PRIMARY KEY NOT NULL,
    orderid INT,
    productID INT,
    quantity INT,
    sub_total DECIMAL(10,2),
    FOREIGN KEY (orderid) REFERENCES orders(orderid),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

-- Insert sample order details
INSERT INTO orders_detail (detailid, orderid, productID, quantity, sub_total) VALUES
(1, 102, 201, 1, 55000.00),
(2, 102, 202, 2, 40001.00),
(3, 103, 203, 3, 4502.25),
(4, 104, 204, 2, 1600.00),
(5, 105, 205, 4, 2001.00);

-- View order details for a specific order
SELECT * FROM orders_detail 
WHERE orderid = 103;

-- View all order details
SELECT * FROM orders_detail;

-- Calculate total revenue per order
SELECT 
    orderid,
    SUM(sub_total * quantity) AS total_revenue 
FROM orders_detail 
GROUP BY orderid;

-- Find top 3 orders with most items
SELECT 
    orderid,
    COUNT(*) AS total_orders 
FROM orders_detail 
GROUP BY orderid 
ORDER BY total_orders DESC 
LIMIT 3;

-- Count how many times each product was sold
SELECT 
    productID,
    COUNT(*) AS total_product_sold 
FROM orders_detail 
GROUP BY productID;
