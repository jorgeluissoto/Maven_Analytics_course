-- ASSIGNMENT: Creating Your own Schema & Tablets
CREATE SCHEMA toms_marketing_stuff DEFAULT CHARSET utf8mb4;

USE toms_marketing_stuff;

CREATE TABLE publishers (
    publisher_id INT,
    publisher_name VARCHAR(65),
    PRIMARY KEY (publisher_id)
);

SELECT *
FROM publishers;

CREATE TABLE publisher_spend (
	publisher_spend_id INT NOT NULL,
    publisher_id INT NOT NULL,
    month DATE NOT NULL,
    spend DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (publisher_spend_id)
);

SELECT *
FROM publisher_spend; 

-- ASSIGNMENT: Adding & Removing Columns
SELECT 
    *
FROM
    employees;

ALTER TABLE employees
DROP COLUMN hourly_wage;

ALTER TABLE employees
ADD COLUMN avg_customer_rating DECIMAL (10,1);

-- ASSIGNMENT: Dropping Schemas & Tables  
DROP TABLE candy_products;

DROP SCHEMA candystore_old;

-- Inserting Records Into Tables
USE thiftshop;

SELECT 
    *
FROM
    inventory;

INSERT INTO inventory VALUES
(10,'wolf skin hat',1);

-- Updating Data Records
USE thiftshop;

SELECT 
    *
FROM
    inventory;

UPDATE inventory 
SET 
    number_in_stock = 0
WHERE
    inventory_id IN (1 , 9); 

-- ASSIGNMENT: Inserting & Updating Records
USE candystore;

SELECT 
    *
FROM
    employees;

INSERT INTO employees VALUES
(7,'Charles', 'Munger','2020-03-15', 'Clerk', '5.0'),
(8,'Willam', 'Gates','2020-03-15', 'Clerk', '5.0');

UPDATE employees 
SET 
    avg_customer_rating = 4.75
WHERE
    employee_id = 5;

ALTER TABLE employees MODIFY avg_customer_rating DECIMAL (10,2);

-- Deleting Specific Records
USE thriftshop;

SELECT 
    *
FROM
    inventory;

-- return of 1 = on, 0 = off
SELECT @@autocommit;

SET autocommit = OFF;

DELETE FROM inventory 
WHERE
    inventory_id = 7;

-- We turned off auto commit so we are able to rollback to previous commit. 
ROLLBACK;

-- This statement will make it final and rollback cannot return that deleted record. 
COMMIT;

-- Deleting All Records with TRUNCATE
USE thriftshop;

SELECT 
    *
FROM
    customers;

SELECT @@autocommit;

DELETE FROM customers 
WHERE
    customer_id BETWEEN 1 AND 6;

ROLLBACK;

-- Even if you run ROLLBACK afte this statement it will not work like with a DELETE statement. 
TRUNCATE TABLE customers;
 
-- ASSIGNMENT: Deleting Records 
USE candystore;

SELECT @@autocommit;

SELECT 
    *
FROM
    employees;

DELETE FROM employees 
WHERE
    employee_id = 4;

ROLLBACK;

COMMIT;

SELECT 
    *
FROM
    customer_reviews;

DELETE FROM customer_reviews 
WHERE
    customer_review_id BETWEEN 1 AND 33;

ROLLBACK;

COMMIT;

-- Primary Keys & Foreign Keys Demo
USE mavenfuzzyfactorymini;

SELECT 
    *
FROM
    orders_mini;

SELECT 
    *
FROM
    order_items_mini
WHERE
    order_id = 9994;-- this is the foreign key, which links to the primary key in orders(order_id)

SELECT 
    *
FROM
    order_item_refunds_mini;

-- ASSIGNMENT: Table Relationships 
/* 1) Tell me what the primary key is, and whether there are any foreign keys
	2) Explain how the tables relate to each other and what type of relationship exist */
USE onlinelearningschool;

SELECT 
    *
FROM
    courses;
-- course_id = primary key

SELECT 
    *
FROM
    course_ratings;
/* rating_id = primary key
	course_id = foreign key (courses table) 
	one - many relationship */

SELECT 
    *
FROM
    course_ratings_summaries;
/* no primary key in this table.
	course_id = foreign key 
    One option here is to add a primary key */

-- Database Normalization Demo
USE mavenfuzzyfactorymini;

SELECT 
    *
FROM
    website_pageviews_non_normalized
WHERE
    website_session_id = 20;

-- CREATE NEW TABLE
CREATE TABLE website_page_views_normalized SELECT website_pageview_id,
    created_at,
    website_session_id,
    pageview_url FROM
    website_pageviews_non_normalized;

SELECT 
    *
FROM
    website_page_views_normalized;

-- CREATE NEW TABLE
CREATE TABLE website_session_normalized
SELECT DISTINCT -- returns only unique session 
    website_session_id,
    session_created_at,
    user_id,
    is_repeat_session,
    utm_source,
    utm_content,
    device_type,
    http_referer
FROM
    website_pageviews_non_normalized;
    
SELECT 
    *
FROM
    website_session_normalized;
    
-- ASSIGNMENT: Normalization
USE onlinelearningschool;

SELECT 
    *
FROM
    courses;

SELECT 
    *
FROM
    course_ratings;
-- no need to have course_id and course_name since you could JOIN to the courses table
ALTER TABLE course_ratings
DROP COLUMN instructor; -- also dropped course_name 

SELECT 
    *
FROM
    course_ratings_summaries;

-- THE UNIQUE CONSTRAINT
SELECT 
    *
FROM
    inventory;

INSERT INTO inventory VALUES
(11,'fur coat', 2);
-- Error Code: 1062. Duplicate entry 'fur coat' for key 'inventory.item_name_UNIQUE'

-- ASSIGNMENT: INDEXES & CONSTRAINTS
USE sloppyjoes;

SELECT 
    *
FROM
    customer_orders;
    
-- make staff_id a foreign key
-- update null values to zero so we can add non null constraint to order_total
UPDATE customer_orders
SET order_total = 0
WHERE order_id IN (3,8,12,16,19);

SELECT 
    *
FROM
    menu_items;
-- menu_item_id will be primary key. item_name = unique constraint. price and item_name will be non null 

SELECT 
    *
FROM
    staff;
-- make staff_id the primary key, make first/ last name / orders served as non null

-- STORED PROCEDURES
USE thriftshop;

SELECT * FROM inventory;

-- changing the delimiter
DELIMITER //
-- creating the procedure
CREATE PROCEDURE sp_selectallInventory()
BEGIN
	SELECT * FROM inventory;
END //
-- changing the delimeter back to the default
DELIMITER ;

-- calling the procedure that we have created
CALL sp_selectallInventory();

-- if we later want to DROP the procedure, we can use this...
DROP PROCEDURE sp_selectallInventory;

-- ASSIGNMENT: STORED PROCEDURES 
USE sloppyjoes;

CALL AllOrders();

DELIMITER //
CREATE PROCEDURE AllOrders()
BEGIN
SELECT staff_id, COUNT(order_id) AS orders_served
FROM customer_orders
GROUP BY staff_id;
END //

DELIMITER ;

-- ASSIGNMENT: TRIGGERS
USE sloppyjoes;

-- use this to see # of orders_served before updates
SELECT 
    *
FROM
    staff;
SELECT 
    *
FROM
    customer_orders;

-- then, create your trigger
CREATE 
    TRIGGER  ordersUpdate
 AFTER INSERT ON customer_orders FOR EACH ROW 
    UPDATE staff SET orders_served = orders_served + 1 WHERE
        staff.staff_id = NEW.staff_id;

-- then, insert these 4 records into customer_orders
INSERT INTO customer_orders VALUES 
(21,1,10.98),
(22,2,5.99),
(23,2,7.99),
(24,2,12.97);

-- finally, query the staff table again
-- if you did this right, orders_served has increased
SELECT 
    *
FROM
    staff; 


