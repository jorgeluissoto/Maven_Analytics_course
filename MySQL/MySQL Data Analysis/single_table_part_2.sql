-- The CASE Statement
SELECT DISTINCT
    length,
    CASE
        WHEN length < 60 THEN 'under 1 hr'
        WHEN length BETWEEN 60 AND 90 THEN '1-1.5 hrs'
        WHEN length > 90 THEN 'over 1.5 hrs'
        ELSE 'uh oh..check logic!'
    END AS length_bucket
FROM
    film;
-- include an error message using an ELSE statement to see if you missed any logic
 
SELECT DISTINCT
    length,
    CASE
        WHEN length < 60 THEN 'under 1 hr'
        WHEN length < 90 THEN '1-1.5 hrs'
        WHEN length > 120 THEN 'over 2 hrs'
        ELSE 'uh oh..check logic!'
    END AS length_bucket
FROM
    film;

-- Common CASE Operators
SELECT DISTINCT
    title,
    CASE
        WHEN rental_duration <= 4 THEN 'rental_too_short'
        WHEN rental_rate >= 3.99 THEN 'too_expensive'
        WHEN rating IN ('NC-17' , 'R') THEN 'too_adult'
        WHEN length NOT BETWEEN 60 AND 90 THEN 'too_short_or_to_long'
        WHEN description LIKE '%Shark%' THEN 'nope_has_sharks'
        ELSE 'great_reco_for_family'
    END AS fit_for_recommendation,
    CASE
        WHEN description LIKE '%Shark%' THEN 'nope_has_sharks'
        WHEN length NOT BETWEEN 60 AND 90 THEN 'too_short_or_to_long'
        WHEN rating IN ('NC-17' , 'R') THEN 'too_adult'
        WHEN rental_duration <= 4 THEN 'rental_too_short'
        WHEN rental_rate >= 3.99 THEN 'too_expensive'
        ELSE 'great_reco_for_family'
    END AS reordered_reco
FROM
    film;

-- Assignment: The CASE Statement
/*I'd like to know which store each customer goes to, and whether or not they are active.
Could you pull a list of first and last names of all customers, and label them as either 'store 1 active','store 1 inactive',
'store 2 active', or 'store 2 inactive'*/
SELECT 
    first_name,
    last_name,
    CASE
        WHEN store_id = 1 AND active = 1 THEN 'store 1 active'
        WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive'
        WHEN store_id = 2 AND active = 1 THEN 'store 2 active'
        WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive'
        ELSE 'uh ok..check your logic'
    END AS store_and_status
FROM
    customer;

-- COUNT & CASE Demo
SELECT 
    film_id,
    COUNT(CASE
        WHEN store_id = 1 THEN inventory_id
        ELSE NULL
    END) AS count_of_store_1_inventory,
    COUNT(CASE
        WHEN store_id = 2 THEN inventory_id
        ELSE NULL
    END) AS count_of_store_2_inventory
FROM
    inventory
GROUP BY film_id
ORDER BY film_id;

-- ASSIGNMENT: COUNT & CASE
/*I'm curious how many inactive customers we have at each store.
Could you please create a table to count the number of customers broken down by store_id(in rows),
and active status (in columns)*/
SELECT store_id,
		COUNT(CASE WHEN store_id = 1 AND active = 1 THEN 'store 1 active' 
				   WHEN store_id = 2 AND active = 1 THEN 'store 2 active' END) AS active,
		COUNT(CASE WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive' 
				   WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive' END) AS inactive
FROM customer
GROUP BY store_id
ORDER BY store_id;

-- Instructor solution
SELECT store_id,
		COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active,
		COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive
FROM customer
GROUP BY store_id
ORDER BY store_id;