
/* ### Instructions

1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
2. List all films whose length is longer than the average of all the films.
3. Use subqueries to display all actors who appear in the film _Alone Trip_.
4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
5. Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client.*/

use sakila;
-- 1. How many copies of the film _Hunchback Impossible_ exist in the inventory system?
select count(film_id) from inventory i 
where film_id in ( select film_id from film where title = 'Hunchback Impossible');

select f.title, count(i.film_id) from inventory i
join film f on i.film_id = f.film_id
where f.title = 'Hunchback Impossible';

-- 2. List all films whose length is longer than the average of all the films.
select film_id, title, length from film 
where length > (select avg(length) from film)
order by length asc;

-- 3. Use subqueries to display all actors who appear in the film _Alone Trip_.
select * from actor a 
where actor_id in 
(select actor_id from film_actor fa
where fa.film_id in (select film_id from film where film.title = 'Alone Trip'));

-- 4. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
select * from film_category
join film on film_category.film_id = film.film_id
where category_id in (select category.category_id from category where category.name = 'family');

-- 5. Get name and email from customers from Canada using subqueries. Do the same with joins. 
-- Note that to create a join, you will have to identify the correct tables with their primary keys and foreign key, 
-- you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.

select c.first_name, c.last_name, c.email from customer c where c.address_id in 
   (select a.address_id from address a where a.city_id in 
       (select cty.city_id from city cty where cty.country_id in
             (select co.country_id from country co where co.country = 'Canada')));


select c.first_name, c.last_name, c.email, co.country from customer c
join address a on c.address_id = a.address_id
join city cty on a.city_id = cty.city_id
join country co on cty.country_id = co.country_id
where co.country = 'Canada';


-- 6. Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films. 
-- First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.

select film_id, title from film where film_id in (
select fma.film_id from film_actor fma where fma.actor_id =
(select fma.actor_id 
from film_actor fma
group by fma.actor_id
having count(fma.actor_id) = (
	select max(actor_count) 
    from (
         select count(fma.actor_id) as actor_count 
         from film_actor fma
         group by fma.actor_id
         ) sub1
)));

-- 7. Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select film_id, title from film where film_id in (
select i.film_id from inventory i where i.inventory_id in (
select r.inventory_id
from rental r
where r.rental_id in(
select r.rental_id
from rental r 
where r.customer_id =
(select customer_id 
from payment
group by customer_id
having sum(amount) = (
select max(cus_profit)from (
select sum(amount) as cus_profit 
from payment 
group by customer_id)
sub1)))));

-- 8. Get the `client_id` and the `total_amount_spent` of those clients who spent more than the average of the `total_amount` spent by each client.
select customer_id as client_id, sum(amount) as total_amount_spent 
from payment
group by customer_id
having sum(amount) > (
select avg(cus_profit) as average from (select sum(amount) as cus_profit 
from payment 
group by customer_id)sub1)
order by total_amount_spent;


