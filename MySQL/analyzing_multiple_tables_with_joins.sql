-- Analyzing Multiple Tables 

-- Inner Joins Example
SELECT DISTINCT
    inventory.inventory_id
FROM
    inventory
        INNER JOIN
    rental ON inventory.inventory_id = rental.inventory_id
LIMIT 5000;

/* Can you pull for me a list of each film we have in inventory?
I would like to see the film's title, description, and the store_id value associated with each item,
and its inventory_id.*/
SELECT 
    inventory_id, store_id, film.title, film.description
FROM
    inventory
        INNER JOIN
    film ON film.film_id = inventory.film_id;