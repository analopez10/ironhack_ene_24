/* ### Instructions

1. Get film ratings.
2. Get release years.
3. Get all films with ARMAGEDDON in the title.
4. Get all films with APOLLO in the title
5. Get all films which title ends with APOLLO.
6. Get all films with word DATE in the title.
7. Get 10 films with the longest title.
8. Get 10 the longest films.
9. How many films include **Behind the Scenes** content?
10. List films ordered by release year and title in alphabetical order.*/

use sakila;

-- 1. Get film ratings.
select title, rating from film;

-- 2. Get release years.
select title, rating, release_year from film;

-- 3. Get all films with ARMAGEDDON in the title.
select title, rating, release_year from film where title like '%ARMAGEDDON%';

-- 4. Get all films with APOLLO in the title
select title, rating, release_year from film where title like '%APOLLO%';

-- 5. Get all films which title ends with APOLLO.
select title, rating, release_year from film where title like '%APOLLO';

-- 6. Get all films with word DATE in the title.
select title, rating, release_year from film where title regexp'DATE';

-- 7. Get 10 films with the longest title.
select title,length(title) from film order by length(title)desc limit 10;

-- 8. Get 10 the longest films.
select title, length from film order by length desc limit 10;

-- 9. How many films include **Behind the Scenes** content?
select count(film_id) from film where special_features like '%Behind the Scenes%';

-- 10. List films ordered by release year and title in alphabetical order
select title, release_year from film order by release_year, title;