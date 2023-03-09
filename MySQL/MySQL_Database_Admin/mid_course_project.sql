-- MID COURSE PROJECT
/* 1. Take a look at the mavenmoviesmini schema. 
What do you notice about it? How many tables are there?
	- only one table is present with all the data.
What does the data represent?
	- it represents inventory items where they are stored and who the manager is at that location. And some
    information about the film
What do you think about the current schema? 
	- it is hard to read all the data since it currently holds 13 columns */
SELECT 
    *
FROM
    inventory_non_normalized;

/* 2. If you wanted to break out the data from the inventory_non_normalized table into multiple tables,
how many tables do you think would be ideal?
	- 3 tables
What would you name those tables? */

-- inventory table (inventory_id, film_id, store_id)
-- film (film_id, title, description, release_year, rental_rate, rating)
-- store (store_id, store_manager_first_name, store_manager_last_name, store_address, store_city, store_district)

/* 3. Based on your answer from question #2, create a new schema with the tables you think will best serve this
data set. You can use SQL code or Workbench's UI tools (whichever you feel more confortable with) */
USE mavenmoviesmini_normalized;

SELECT 
    *
FROM
    store;

SELECT 
    *
FROM
    film;

SELECT 
    *
FROM
    inventory;

/* 4. Next, use the data from the original schema to populate the tables in your newly optimized schema */
INSERT INTO inventory (inventory_id, film_id, store_id)
SELECT DISTINCT inventory_id, film_id, store_id
FROM mavenmoviesmini.inventory_non_normalized;

INSERT INTO film (film_id, title, description, release_year, rental_rate, rating)
SELECT DISTINCT film_id, title, description, release_year, rental_rate, rating
FROM mavenmoviesmini.inventory_non_normalized;

INSERT INTO store (store_id, store_manager_first_name, store_manager_last_name, store_address, store_city, store_district)
SELECT DISTINCT store_id, store_manager_first_name, store_manager_last_name, store_address, store_city, store_district
FROM mavenmoviesmini.inventory_non_normalized;

/* 5. Make sure your new tables have the proper primary keys and that applicable foreign keys are added.
Add any constraints you think should apply to the data as well (unique, non-null, etc) */
-- double checked all 3 tables to ensure everything was good 


/* 6. Finally, after doing all of this techinal work, write a brief summary  of what you have done, in a way that your
non-techinal client can understand. Communicate what you did, and why your schema design is better 

The original table that we had stored all the information in one table. This lead to multiple records like movie
title all showing in the table. Making it very hard to understand the data. We took that table and broke it down 
into 3 table inventory, store, and film. This deletes the duplicate records and leads us with 3 clean tabels. Since
their are only 2 manager we now have a table with only the information of the two stores.*/
