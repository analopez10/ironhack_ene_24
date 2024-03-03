/* 1. Use sakila database.
2. Get all the data from tables `actor`, `film` and `customer`.
3. Get film titles.
4. Get unique list of film languages under the alias `language`. Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.
5.
  - 5.1 Find out how many stores does the company have?
  - 5.2 Find out how many employees staff does the company have? 
  - 5.3 Return a list of employee first names only?

6. Select all the actors with the first name ‘Scarlett’.
7. Select all the actors with the last name ‘Johansson’.
8. How many films (movies) are available for rent?
9. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
10. What's the average movie duration?
11. How many movies are longer than 3 hours?
12. What's the length of the longest film title?*/

use sakila;

-- 2. Get all the data from tables `actor`, `film` and `customer`.
select * from actor;
select * from film;
select * from customer;

-- 3. Get film titles
select film.title from film;

-- 4. Get unique list of film languages under the alias `language`. 
-- Note that we are not asking you to obtain the language per each film, but this is a good time to think about how you might get that information in the future.
 
 select distinct name from language;
 
 /* 5.
  - 5.1 Find out how many stores does the company have?
  - 5.2 Find out how many employees staff does the company have? 
  - 5.3 Return a list of employee first names only?*/
select count(store_id) from store;
select count(staff_id) from staff;
select first_name from staff;

-- 6. Select all the actors with the first name ‘Scarlett’.
select * from actor where first_name = 'Scarlett';

-- 7. Select all the actors with the last name ‘Johansson’.
select * from actor where last_name = 'Johansson';

-- 8. How many films (movies) are available for rent?
select count(film_id) from inventory;

-- 9. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
select min(length) as min_duration,  max(length) as max_duration from film;

-- 10. What's the average movie duration?
select avg(length) as avg_duration from film;

-- 11. How many movies are longer than 3 hours?
select count(film_id) from film where length > 3*60;

-- 12. What's the length of the longest film title?
select max(length(title)) from film;
