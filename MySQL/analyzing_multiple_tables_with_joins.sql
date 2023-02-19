-- Analyzing Multiple Tables 

-- INNER JOIN Example
SELECT DISTINCT
    inventory.inventory_id
FROM
    inventory
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

-- INNER JOIN ASSIGNMENT  
/* Can you pull for me a list of each film we have in inventory?
I would like to see the film's title, description, and the store_id value associated with each item,
and its inventory_id.*/
SELECT 
    inventory_id, store_id, film.title, film.description
FROM
    inventory
        INNER JOIN
    film ON film.film_id = inventory.film_id;

-- LEFT JOIN Example
SELECT DISTINCT
    inventory.inventory_id, rental.inventory_id
FROM
    inventory
        LEFT JOIN
    rental ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

-- LEFT JOIN ASSIGNMENT 
/*One of our investors is interested in the films we carry and how many actors are listed for each film title.
Can you pull alist of all titles, and figures out how many actors are associated with each title?*/
SELECT 
    title, COUNT(actor_id) AS count_of_actors
FROM
    film
        LEFT JOIN
    film_actor ON film_actor.film_id = film.film_id
GROUP BY title;

-- "Bridging" Unrelated Tables
SELECT 
    film.film_id, film.title, category.name AS category_name
FROM
    film
        INNER JOIN
    film_category ON film.film_id = film_category.film_id
        INNER JOIN
    category ON film_category.category_id = category.category_id;

-- "Bridging" Assignment 
/*Customer often ask which films their favorite actors appear in. It would be great to have a list of all actors,
with each title that they apper in. Could you please pull that for me?*/
SELECT 
    actor.first_name, actor.last_name, film.title
FROM
    film
        INNER JOIN
    film_actor ON film.film_id = film_actor.film_id
        INNER JOIN
    actor ON actor.actor_id = film_actor.actor_id;

-- Multi-Condition Join Assignment
/*The manager from store 2 is working on expanding our film collection there.
Could you pull a list of distict titles and their description, currently available in inventory at store 2?*/
SELECT DISTINCT
    film.title, film.description
FROM
    film
        INNER JOIN
    inventory ON film.film_id = inventory.film_id
        AND inventory.store_id = 2;

-- UNION Operator Example
SELECT 
    'advisor' AS type, first_name, last_name
FROM
    advisor 
UNION SELECT 
    'investor' AS type, first_name, last_name
FROM
    investor;

/* We will be hosting a meeting with all our staff and advisor soon. Could you pull one list of all staff
and advisor names, and include a column noting whether they are a staff member or advisor? Thank*/
SELECT 
    'advisor' AS type, first_name, last_name
FROM
    advisor 
UNION SELECT 
    'staff' AS type, first_name, last_name
FROM
    staff;