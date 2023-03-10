/*SELECT*FROM*/
SELECT 
    *
FROM
    rental;

/*Selecting Specific Columns*/
SELECT 
    customer_id, rental_date
FROM
    rental;
    
/*ASSIGNMENT: SELECT & FROM*/
/*Could you pull a list of the first and last name, and email of each of our customer*/
SELECT 
    first_name, last_name, email
FROM
    customer;
    
/*SELECT DISTINCT*/
/*returns 1000 rows*/
SELECT 
    rating
FROM
    film;
    
/*returns 5 rows*/
SELECT DISTINCT
    rating
FROM
    film;

-- Assignment
/*My understanding is that we have titles that we rent for durations of 3,5,or 7 days.
Could you pull the records of our films and see if there are any other rental durations*/
SELECT DISTINCT
    rental_duration
FROM
    film;

-- The WHERE Clause
-- Run with no where clause...returns 16049 records 
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment;

-- Run with WHERE clause
-- this returns 2979 records
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    amount = 0.99;
    
-- WHERE clause filter by dates
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    payment_date > '2006-01-01'; 

-- Assignment
/*I'd like to look at payment records for our long-term customers to learn about their purchase patterns.
Could you pull all payments from our first 100 customers(based on customer ID)*/
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    customer_id <= 100;
    
-- Combining: WHERE and AND
-- The more AND statement we add the smaller our record return get
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    amount = 0.99 AND payment_date > '2006-01-01'; 

-- Assignment 
/*The payment data you gave me on our first 100 customers was great
Now I'd love to see just payment over $5 for those same customers since Jan, 1st 2006*/
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    customer_id <= 100 AND amount >= 5.00
        AND payment_date > '2006-01-01';

-- Combining WHERE & OR
-- The more OR statement we add the bigger our record return get
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    customer_id = 5 OR customer_id = 11
        OR customer_id = 29;
        
-- Assignment
/*The data you shared previously on customer 42,53,60, and 75 was good to see.
Now, could you please write a query to pull all payments from those specific customers, along with payments
over $5, from any customer*/
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    amount > 5 OR customer_id = 42
        OR customer_id = 53
        OR customer_id = 60
        OR customer_id = 75;
        
-- Combining WHERE & IN
/*If you find yourself writing multiple OR conditions that reference different values in the same column, 
you can use IN( ) to save some time. Chaneg the query above to include IN*/
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
WHERE
    amount > 5 OR customer_id IN (42,53,60,75);

-- The LIKE Operator
/* any character in the column match your pattern, even if there are extra character before or after*/
SELECT 
    title, description
FROM
    film
WHERE
    description LIKE '%Epic%';

/* if the last character in the column match your pattern, even if they are preceded by others */
SELECT 
    title, description
FROM
    film
WHERE
    description LIKE '%China';

-- if any character in the column match your pattern, even if there is exactly 1 character before or after
SELECT 
    title, description
FROM
    film
WHERE
    title LIKE '_LADDIN CALENDA_';

-- Assignment
/*We need to understand the specfic feature in our films. Could you pull a list of films which include a 
Behind the Scenes special feature*/
SELECT 
    title, special_features
FROM
    film
WHERE
    special_features LIKE '%Behind the Scenes%';

-- GROUP BY Example
SELECT 
    rating, COUNT(film_id)
FROM
    film
GROUP BY rating;

-- Using Comments & Aliases
-- STEP 1: pulling all ratings
SELECT 
    rating,
    COUNT(film_id),
    COUNT(film_id) AS count_of_films_with_this_rating -- single line comment
FROM
    film
GROUP BY rating;

-- Assignment: GROUP BY
/*I need to get a quick overview of how long our movies tend to be rented out for.
Could you please pull a count of titles sliced by rental duration.*/
SELECT 
    rental_duration,
    COUNT(film_id) AS films_with_this_rental_duration
FROM
    film
GROUP BY rental_duration;

-- Multiple Dimension GROUP BY Clause
SELECT 
    rental_duration,
    rating,
    replacement_cost,
    COUNT(film_id) AS count_of_films
FROM
    film
GROUP BY rental_duration , rating , replacement_cost;

-- Aggregate Functions
SELECT 
    rating,
    COUNT(film_id) AS count_of_films,
    MIN(length) AS shortest_film,
    MAX(length) AS longest_film,
    AVG(length) AS average_length_of_film,
    SUM(length) AS total_minutes,
    AVG(rental_duration) AS average_rental_duration
FROM
    film
GROUP BY rating;

-- Assignment: Aggregate Function
/* I'm wondering if we charge more for rental when the replacement cost is higher.
Can you help me pull a count of films, along with the average, min, and max rental rate,
grouped by replacement cost?*/
SELECT 
    replacement_cost,
    COUNT(film_id) AS number_of_films,
    MIN(rental_rate) AS cheapest_rental,
    MAX(rental_rate) AS most_expensive_rental,
    AVG(rental_rate) AS average_rental
FROM
    film
GROUP BY replacement_cost;

-- HAVING examples
SELECT 
    customer_id, COUNT(rental_id) AS total_rentals
FROM
    rental
GROUP BY customer_id
HAVING COUNT(rental_id) >= 30;

-- Assignment
/* I'd like to talk to customers that have not rented much from us to understand if there is 
something we could be doing better.
Could you pull a list of customer_ids with less than 15 rentals all time?*/
SELECT 
    customer_id, COUNT(rental_id) AS total_rentals
FROM
    rental
GROUP BY customer_id
HAVING COUNT(rental_id) < 15;

-- The ORDER BY clause
SELECT 
    customer_id, rental_id, amount, payment_date
FROM
    payment
ORDER BY amount DESC , customer_id;

-- ORDER BY clause
SELECT 
    customer_id, 
    SUM(amount) AS total_payment_amount
FROM
    payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- Assignment
/*I'd like to see if our longest films also tend to be our most expensive rentals.
Could you pull me a list of all films titles along with the lenghts and rental rates, and sort them from longest
to shortest*/
SELECT 
    title, length, rental_rate
FROM
    film
ORDER BY length DESC;