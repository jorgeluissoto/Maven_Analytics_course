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

-- RIGHT JOIN 



