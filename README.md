# 📊 Data-Driven Retail Database System (SQL Project)

## 📌 Overview

This project is a **data-driven retail database system** built using SQL. It focuses on storing, managing, and analyzing data to generate meaningful business insights.

The system simulates a real-world retail environment where decisions are made based on **data analysis** such as sales trends, customer behavior, and product performance.

---

## 🎯 Objective

* Build a structured database for retail operations
* Perform **data-driven analysis** using SQL queries
* Extract insights to support business decisions

---

## 🗂️ Database Schema

### 🧑 Customers

Stores customer details:

* `customerID` (Primary Key)
* `name`
* `email` (Unique)
* `address`

---

### 🛒 Orders

Stores order transactions:

* `orderid` (Primary Key)
* `customerid`
* `order_date`
* `total_amount`

---

### 📦 Products

Stores product inventory:

* `productID` (Primary Key)
* `product_name`
* `price`
* `stock`

---

### 📑 Orders Detail

Links orders with products:

* `detailid` (Primary Key)
* `orderid` (Foreign Key)
* `productID` (Foreign Key)
* `quantity`
* `sub_total`

---

## ⚙️ Key Features

### ✅ Data Management

* Insert, update, delete, and retrieve data
* Maintain data integrity using **primary and foreign keys**

---

### 📊 Data-Driven Analysis

#### 🔹 Sales Insights

* Total revenue per order
* Highest and lowest order values
* Average order value

#### 🔹 Product Analysis

* Most sold products
* Cheapest product
* Price-based filtering

#### 🔹 Customer Insights

* Orders by customer
* Purchase patterns

---

## 📈 Sample Analytical Queries

### 🔸 Total Revenue per Order

```sql
SELECT orderid, SUM(sub_total * quantity) AS total_revenue
FROM orders_detail
GROUP BY orderid;
```

### 🔸 Most Sold Products

```sql
SELECT productID, COUNT(*) AS total_sold
FROM orders_detail
GROUP BY productID;
```

### 🔸 Average Order Value

```sql
SELECT AVG(total_amount) FROM orders;
```

---

## 🚀 How to Run
