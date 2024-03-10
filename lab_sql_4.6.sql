/* ### Instructions

1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.
2. Rank films by length within the `rating` category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.  
3. How many films are there for each of the categories in the category table? **Hint**: Use appropriate join between the tables "category" and "film_category".
4. Which actor has appeared in the most films? **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
5. Which is the most active customer (the customer that has rented the most number of films)? **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.
6. List the number of films per category.
7. Display the first and the last names, as well as the address, of each staff member.
8. Display the total amount rung up by each staff member in August 2005.
9. List all films and the number of actors who are listed for each film.
10. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
11. Write a query to display for each store its store ID, city, and country.
12. Write a query to display how much business, in dollars, each store brought in.
13. What is the average running time of films by category?
14. Which film categories are longest?
15. Display the most frequently rented movies in descending order.
16. List the top five genres in gross revenue in descending order.
17. Is "Academy Dinosaur" available for rent from Store 1?*/

-- 1
select title, rank() over (order by length desc) as Rank_, length 
from sakila.film 
where length is not null and length <> ' ';

-- 2 
select title, rank() over (order by length desc) as Rank_, length, rating
from sakila.film 
where length is not null and length <> ' ';

-- 3 How many films are there for each of the categories in the category table? **Hint**: Use appropriate join between the tables "category" and "film
select c.name, count(f.film_id) from film_category f
join category c on f.category_id = c.category_id
group by c.name;

-- 4. Which actor has appeared in the most films? **Hint**: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears. 
select a.first_name, a.last_name, count(f.actor_id) 
from film_actor f
join actor a on f.actor_id = a.actor_id
group by f.actor_id
order by count(f.actor_id) desc
limit 1;

-- 5. Which is the most active customer (the customer that has rented the most number of films)? **Hint**: Use appropriate join between the tables "customer" and "rental" and count the `rental_id` for each customer.
select c.first_name, c.last_name, count(r.rental_id) as 'nº of rents'
from customer c
join rental r on c.customer_id = r.customer_id
group by r.customer_id
order by count(r.rental_id) desc
limit 1;

-- 6. List the number of films per category.
select c.name, count(f.film_id) from film_category f
join category c on f.category_id = c.category_id
group by c.name;

-- 7. Display the first and the last names, as well as the address, of each staff member.
select s.first_name, s.last_name, a.address 
from staff s
join address a on s.address_id = a.address_id
group by a.address_id, s.first_name, s.last_name, a.address;


-- 8. Display the total amount rung up by each staff member in August 2005.

select s.first_name, s.last_name, count(p.payment_id) as 'total amount rung up'
from staff s
join payment p on s.staff_id = p.staff_id
group by s.first_name, s.last_name, p.staff_id;

-- 9. List all films and the number of actors who are listed for each film.
select f.title, count(a.actor_id) as 'nº of actors'
from film f
join film_actor a on f.film_id = a.film_id
group by a.film_id, f.title;


-- 10. Using the payment and the customer tables as well as the JOIN command, list the total amount paid by each customer. List the customers alphabetically by their last names.
select c.first_name, c.last_name, sum(p.amount) as 'total payment'
from customer c
join payment p on c.customer_id = p.customer_id
group by c.first_name, c.last_name, p.customer_id;


-- 11. Write a query to display for each store its store ID, city, and country.
select s.store_id, ct.city, co.country
from store s
join address a on s.address_id = a.address_id
join city ct on a.city_id = ct.city_id
join country co on ct.country_id = co.country_id
group by s.store_id;


-- 12. Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as 'total amount generated'
from store s
join payment p on s.manager_staff_id = p.staff_id
group by s.store_id, p.staff_id;

-- 13. What is the average running time of films by category?
select c.name, avg(f.length) as 'avg length per category'
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.category_id;

-- 14. Which film categories are longest?
select c.name, avg(f.length) as 'avg length per category'
from film f
join film_category fc on f.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.category_id
order by avg(f.length) desc
limit 5;

-- 15. Display the most frequently rented movies in descending order.
select f.title, count(r.rental_id) as 'rented times'
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id
order by  count(r.rental_id) desc;

-- 16. List the top five genres in gross revenue in descending order.

select c.name, sum(p.amount) as 'gross revenue'
from payment p
join rental r on p.rental_id = r.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id = c.category_id
group by c.category_id
order by sum(p.amount) desc
limit 5;

-- 17. Is "Academy Dinosaur" available for rent from Store 1?
select f.title, count(i.store_id) as 'inventory count'
from film f
join inventory i on f.film_id = i.film_id
where f.title = 'Academy Dinosaur' and i.store_id = 1;