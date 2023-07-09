# Importación de DataBase
use sakila;
-- How many copies of the film Hunchback Impossible exist in the inventory system?
select * from film; -- film_id, title
select * from inventory; -- inventory_id, film_id

SELECT film.title, count(inventory.inventory_id) AS Inventory_Q
FROM film
JOIN  inventory ON film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible'
GROUP BY film.title;

-- List all films whose length is longer than the average of all the films.
SELECT title, length FROM (
  SELECT title, length, (SELECT AVG(length) FROM sakila.film) AS avg_length
  FROM sakila.film
) sub1
WHERE length > avg_length;

-- Use subqueries to display all actors who appear in the film Alone Trip.
select * from actor; -- actor_id, first_name, last_name
select * from film_actor; -- actor_id, film_id
select * from film; -- film_id, title

SELECT FN, LN, Film_Title FROM (
	SELECT actor.actor_id, actor.first_name AS FN, actor.last_name AS LN, film.title AS Film_Title 
	FROM actor
	JOIN film_actor ON actor.actor_id = film_actor.actor_id
	JOIN film ON film_actor.film_id = film.film_id) SUB2
WHERE Film_Title = 'Alone Trip';

-- Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
-- Identify all movies categorized as family films.
select * from category; -- category_id, name
select * from film_category; -- film_id, category_id
select * from film; -- film_id, title

SELECT Category_Movie, Movie FROM (
	select category.category_id, category.name AS Category_Movie, film_category.film_id, film.title AS Movie from category
	join film_category on category.category_id = film_category.category_id
	join film on film_category.film_id = film.film_id) SUB3
WHERE Category_Movie = 'Family';

-- Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
-- that will help you get the relevant information.
select * from customer; -- first_name, last_name, email, address_id
select * from address; -- address_id, city_id
select * from city; -- city_id, country_id
select * from country; -- country_id, country

SELECT Country, FN, LN, Email FROM ( 
    select customer.first_name AS FN, customer.last_name AS LN, customer.email AS Email, country.country AS Country from customer
	join address ON customer.address_id = address.address_id
	join city ON address.city_id = city.city_id
	join country ON city.country_id = country.country_id) SUB4
WHERE Country = 'Canada';

-- Which are films starred by the most prolific actor? 
-- Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

# Prolific actor
-- No pude hacer la query utilizando MAX()

SELECT C_Movies, FN, LN FROM (
	SELECT COUNT(actor.actor_id) AS C_Movies, actor.first_name AS FN, actor.last_name AS LN FROM actor
	JOIN film_actor ON actor.actor_id = film_actor.actor_id
	JOIN film ON film_actor.film_id = film.film_id
	GROUP BY FN, LN
	ORDER BY C_Movies DESC) SUB5
GROUP BY FN, LN
ORDER BY C_Movies DESC
LIMIT 1;

-- Films rented by most profitable customer. 
-- You can use the customer table and payment table to find the most profitable customer ie the customer 
-- that has made the largest sum of payments
select * from customer; -- customer_id, FN, LN
select * from payment; -- customer_id, amount

SELECT FN, LN, MAX(Total_Amount) AS MAX_T_A FROM (
	SELECT customer.first_name AS FN, customer.last_name AS LN, SUM(payment.amount) AS Total_Amount FROM customer
	JOIN payment ON customer.customer_id = payment.customer_id
	GROUP BY FN, LN) SUB6
GROUP BY FN, LN
ORDER BY MAX_T_A DESC
LIMIT 1;

-- Get the client_id and the total_amount_spent of those clients who spent more than the 
-- average of the total_amount spent by each client.
    
    
    
    
    
    
    
    
    
    
    
    

