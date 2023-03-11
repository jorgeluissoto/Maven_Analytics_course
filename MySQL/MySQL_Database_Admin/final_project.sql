/* Bubs wants you to track information on his customers (first name, last name, email), his employee (first name,
last name, start date, position held), his products, and the purchases customers make (which customer, when it was
purchased , for how much money). Think about how many tables you should create. Which data goes in which tables?
How should the tables relate to one another? */

-- TABLE: customer
-- customer_id, first. last, email

-- TABLE: employees
-- employee_id, first, last, start_date, position

-- TABLE: products
-- product_id, product_name, launched_date

-- TABLE: customer_purchases
-- customer_purchase_id, customer_id, product_id, purchased_at, amount_usd        

/* Given the database design you came up with, use Workbench to create an ERR diagram of the database. Include 
things like primary keys and foreign keys, and anythimg else you think you should have in a tables. Make sure to use
reasonable data types for each column. */

-- image of ERR is avalable on request 

/* Create a schema called bubsbooties. Within that schema, create the tables that you have diagramed out. Make
sure they relate to each other, and that they have the same reasonable data tyes you selected previously */

-- created 4 tables using MySQL Workbench UI
USE bubsbooties;

SELECT 
    *
FROM
    products;
    
SELECT 
    *
FROM
    customers;
    
SELECT 
    *
FROM
    employees;
    
SELECT 
    *
FROM
    customer_purchases;

/* Add any constraints you think your tables column should have. Think through which columns need to be unique,
which ones are allowed to have NULL values, etc */

-- added unique constrait to product_name 
-- added unique constrait to the email so only one email per customer

/* Insert at least records of data into each table. The exact values do not matter, so feel free to make them up.
Just make sure that the data you insert makes sense, and that the tables tie together. */

-- Product
INSERT INTO products VALUES
(1,'Mickey Ice Cream','2022-03-23'),
(2, 'Mickey Ears', '2018-09-10'),
(3,'Tron figure','2023-03-01');

-- Customers
INSERT INTO customers VALUES
(1,'Jorge','Soto','jls@jorge.com'),
(2, 'Gen','Perez','gen@gmail.com'),
(3,'Joe','Smith','smith@gmail.com'); 

-- employees
INSERT INTO employees VALUES
(1,'Mark','Adams','Cashier','2020-03-04'),
(2,'John','Lee','Manager','2019-05-02'),
(3,'John','Soto','Sales man','2021-09-07');

-- Customer Puchases
INSERT INTO customer_purchases VALUES
(1,3,2,3,'2023-02-15','30.99'),
(2,1,1,2,'2023-02-19','6.99'),
(3,3,3,1,'2023-02-23','25.99');
 

/* Create two users and give them access to the database. The first user, TuckerReilly, will be the DBA, and should 
get full database admin privileges. The second user, EllaBrody, is an Analyst, and only needs read access. */

-- completed in Admin dashboard 
