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

SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM employees;
SELECT * FROM customer_purchases;

/* Add any constraints you think your tables column should have. Think through which columns need to be unique,
which ones are allowed to have NULL values, etc */

-- added unique constrait to product_name 

/* Insert at least records of data into each table. The exact values do not matter, so feel free to make them up.
Just make sure that the data you insert makes sense, and that the tables tie together. */

/* Create two users and give them access to the database. The first user, TuckerReilly, will be the DBA, and should 
get full database admin privileges. The second user, EllaBrody, is an Analyst, and only needs read access. */
