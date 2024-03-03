/*Instructions

1. How many distinct (different) actors' last names are there?
2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
3. How many movies were released with `"PG-13"` rating?
4. Get 10 the longest movies from 2006.
5. How many days has been the company operating (check `DATEDIFF()` function)?
6. Show rental info with additional columns month and weekday. Get 20.
7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.
8. How many rentals were in the last month of activity?*/

-- 1. How many distinct (different) actors' last names are there?
select count(distinct (last_name)) from actor;

-- 2. In how many different languages where the films originally produced? (Use the column `language_id` from the `film` table)
select count(distinct (language_id)) from film;

-- 3. How many movies were released with `"PG-13"` rating?
select count(film_id) from film where rating = 'PG-13';

-- 4. Get 10 the longest movies from 2006.
select title, length from film where release_year = 2006 order by length desc limit 10;

-- 5. How many days has been the company operating (check `DATEDIFF()` function)?
-- select DATEDIFF(payment_date,payment_date);

-- 6. Show rental info with additional columns month and weekday. Get 20.
select *, date_format(convert(rental_date, datetime), "%W") as weekday , date_format(convert(rental_date, datetime), "%M") as month from rental;

-- 7. Add an additional column `day_type` with values 'weekend' and 'workday' depending on the rental day of the week.

select *, date_format(convert(rental_date, datetime), "%W") as weekday , date_format(convert(rental_date, datetime), "%M") as month,
case 
when date_format(convert(rental_date, datetime), "%W") in ('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') then 'Workday'
else 'Weekend'
end as 'day_type'
from rental;

-- 8. How many rentals were in the last month of activity?
select count(*) from rental where date_format(convert(rental_date, datetime), "%M") = 'May';


