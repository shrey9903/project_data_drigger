create database sample;

use sample;

create table customers(
customerID int primary key not null,
name varchar(50),
email varchar(50) unique,
address varchar(100)
);

INSERT INTO customers (customerID, name, email, address) VALUES
(1, 'Amit Sharma', 'amit.sharma@gmail.com', 'Mumbai, Maharashtra'),
(2, 'Priya Patel', 'priya.patel@gmail.com', 'Surat, Gujarat'),
(3, 'Rahul Verma', 'rahul.verma@gmail.com', 'Delhi, India'),
(4, 'Sneha Reddy', 'sneha.reddy@gmail.com', 'Hyderabad, Telangana'),
(5, 'Arjun Singh', 'arjun.singh@gmail.com', 'Jaipur, Rajasthan');

select * from customers;

update customers set address=" Ahmedabad, Gujarat" where customerID=4; 

delete from customers where customerID=5;

select * from customers where name ="Alice";

create table orders(
orderid int primary key not null,
customerid int,
order_date date,
total_amount decimal(10,3)
);

INSERT INTO orders (orderid, customerid, order_date, total_amount) VALUES
(101, 1, '2026-03-01', 1500.500),
(102, 2, '2026-03-05', 2300.750),
(103, 3, '2026-03-10', 999.999),
(104, 4, '2026-03-15', 1750.250),
(105, 5, '2026-03-20', 3200.000);

select * from orders where customerid=2;
select * from orders;

update orders
set total_amount=5000
where orderid=104;

delete from orders where orderid=101;

select * from orders
where order_date>=CURDATE() - interval 30 day;

select max(total_amount) as highest_order_am,
min(total_amount) as lowest_order_am,
avg(total_amount) as average_order_amo from orders;

create table products(
productID int primary key not null,
product_name varchar(20),
price decimal(10,2),
stock int
);

INSERT INTO products (productID, product_name, price, stock) VALUES
(201, 'Laptop', 55000.00, 10),
(202, 'Smartphone', 20000.50, 25),
(203, 'Headphones', 1500.75, 50),
(204, 'Keyboard', 800.00, 30),
(205, 'Mouse', 500.25, 40);

select * from products order by price desc;

update products set price= 7369.36 where productID=203;

delete from products where stock<0;

select * from products where price between 500 and 2000;

select product_name from products where price =(select min(price) from products);

CREATE TABLE orders_detail (
    detailid INT PRIMARY KEY NOT NULL,
    orderid INT,
    productID INT,
    quantity INT,
    sub_total DECIMAL(10,2),
    FOREIGN KEY (orderid) REFERENCES orders(orderid),
    FOREIGN KEY (productID) REFERENCES products(productID)
);

INSERT INTO orders_detail (detailid, orderid, productID, quantity, sub_total) VALUES
(1, 102, 201, 1, 55000.00),
(2, 102, 202, 2, 40001.00),
(3, 103, 203, 3, 4502.25),
(4, 104, 204, 2, 1600.00),
(5, 105, 205, 4, 2001.00);

select * from orders_detail where orderid=103;

select * from orders_detail;

select orderid,sum(sub_total*quantity) as 'total_revenue' from orders_detail group by orderid;  

select orderid,count(*) as 'total_orders' from orders_detail group by orderid order by total_orders desc limit 3;

select productID,count(*) as 'total_product_selled' from orders_detail group by productID; 