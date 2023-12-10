/*1. In the email system there was a problem with names 
where either the first name or the last name is more 
than 10 characters long.
Find these customers and output the list of these first and last
names in all lower case.*/
select lower(first_name) as first_names,
lower(last_name) as last_names,
lower(email) as email
from customer
where length(first_name) > 10 or length(last_name) > 10;

/*2. Extract the last 5 characters of the email address first.
The email address always ends with '.org'.
How can you extract just the dot '.' from the email address?*/
select right(email,5),
left(right(email,4),1)
from customer;

/*3. You need to create an anonymized version of the email addresses.
It should be the first character followed by '***' and then
the last part starting with '@'.
Note the email address always end with @sakilacustomer.org*/
select left(email,1) || '***' || right(email,19) as anonymized_email
from customer;

/*4. In this challenge you have only the email address and the last
name of the customers
You need to extract the first name from the email address and
concatenate it with the last name. It should be in the form:
"Last name, First name".*/
select email, 
position(last_name in email), 
left(email,position(last_name in email)-2),
last_name || ',' || left(email,position(last_name in email)-2)
from customer
limit 2;

/*5.You need to create an anonymized form of the email addresses*/
select email,
left(email,1) || '***' || 
substring(email from position('.'in email) for 2) || 
'***' || substring(email from position('@'in email))
from customer;

select email,
'***' || 
substring(email from position('.' in email)-1 for 1) || 
substring(email from position('.' in email) for 2) || 
'***' ||substring(email from position('@' in email))
from customer;

/*6.You need to analyze the payments and find out the following:
▪ What's the month with the highest total payment amount?
▪ What's the day of week with the highest total payment amount?
(0 is Sunday)
▪ What's the highest amount one customer has spent in a week?*/
select extract(month from payment_date) as month,
sum(amount) as total_payment_amount
from payment
group by month
order by sum(amount) desc;

select extract(dow from payment_date) as day_of_week,
sum(amount) as total_payment_amount
from payment
group by day_of_week
order by sum(amount) desc;

select extract(week from payment_date) as week,
customer_id,
sum(amount) as total_payment_amount
from payment
group by week, customer_id
order by sum(amount) desc;

/*7.You need to sum payments and group in the following formats*/
select sum(amount) as total_amount,
to_char(payment_date, 'Dy,DD/MM/YYYY') as day
from payment
group by day
order by total_amount;

select sum(amount) as total_amount,
to_char(payment_date, 'Mon,YYYY') as day
from payment
group by day
order by total_amount;

select sum(amount) as total_amount,
to_char(payment_date, 'Dy,HH:MI') as day
from payment
group by day;

/*8.You need to create a list for the suppcity team of all rental
durations of customer with customer_id 35.
Also you need to find out for the suppcity team
which customer has the longest average rental duration?*/
select customer_id,
return_date - rental_date as rental_duration
from rental
where customer_id = 35;

select customer_id,
avg(return_date - rental_date)
from rental
group by customer_id
order by avg(return_date - rental_date) desc;

/*9.Your manager is thinking about increasing the prices for films
that are more expensive to replace.
For that reason, you should create a list of the films including the
relation of rental rate / replacement cost where the rental rate
is less than 4% of the replacement cost.
Create a list of that film_ids together with the percentage rounded
to 2 decimal places. For example 3.54 (=3.54%)*/
select film_id,
round((rental_rate*100/replacement_cost),2) as percentage
from film
where round((rental_rate*100/replacement_cost),2) < 4
order by percentage;

/*10.You want to create a tier list in the following way:
1. Rating is 'PG' or 'PG-13' or length is more then 210 min:
'Great rating or long (tier 1)
2. Description contains 'Drama' and length is more than 90min:
'Long drama (tier 2)'
3. Description contains 'Drama' and length is not more than 90min:
'Shcity drama (tier 3)'
4. Rental_rate less than $1:
'Very cheap (tier 4)'
If one movie can be in multiple categories it gets the higher tier assigned.
How can you filter to only those movies that appear in one of these 4 tiers?*/
select title,
case 
when (rating in ('PG','PG-13')) or (length > 210) then 'Great rating or long (tier 1)'
when (description like '%Drama%') and (length > 90) then 'Long drama (tier 2)'
when (description like '%Drama%') and (length < 90) then 'Shcity drama (tier 3)'
when rental_rate < 1 then 'Very cheap (tier 4)'
end as case
from film
where 
case 
when (rating in ('PG','PG-13')) or (length > 210) then 'Great rating or long (tier 1)'
when (description like '%Drama%') and (length > 90) then 'Long drama (tier 2)'
when (description like '%Drama%') and (length < 90) then 'Shcity drama (tier 3)'
when rental_rate < 1 then 'Very cheap (tier 4)'
end is not null;

/*11.sum rating by category but in pivot table*/
select 
sum(case when rating = 'G' then 1 else 0
end)as "G",
sum(case when rating = 'R' then 1 else 0
end)as "R",
sum(case when rating = 'NC-17' then 1 else 0
end)as "NC-17",
sum(case when rating = 'PG-13' then 1 else 0
end)as "PG-13",
sum(case when rating = 'PG' then 1 else 0
end)as "PG"
from film;

/*12.Handling missing value in return_date from rental table 
with 'Not returned'*/
select rental_date,
coalesce(cast(return_date as VARCHAR),'Not returned')
from rental
order by rental_date desc;

/*13.The company wants to run a phone call campaing on all customers in
Texas (=district).
What are the customers (first_name, last_name, phone number and their
district) from Texas?
Are there any (old) addresses that are not related to any customer?
Result*/
select first_name, 
last_name, 
phone,
district
from customer c
left join address a
on c.address_id = a.address_id
where district = 'Texas';

select *
from address a
left join customer c
on c.address_id = a.address_id
where customer_id is null;

/*14.The company wants customize their campaigns to customers depending on
the country they are from.
Which customers are from Brazil?
Write a query to get first_name, last_name, email and the country from all
customers from Brazil.*/
select first_name,
last_name,
email,
country
from customer c
left join address a
on c.address_id = a.address_id
left join city ci
on a.city_id = ci.city_id
left join country co
on ci.country_id = co.country_id
where country = 'Brazil';

/*15.Which title has GEORGE LINTON rented the most often?*/
select c.customer_id, 
first_name, 
last_name, 
title,
count(*)
from customer c
left join rental r
on c.customer_id = r.customer_id
left join inventory i
on r.inventory_id = i.inventory_id
left join film f
on i.film_id = f.film_id
where first_name = 'GEORGE' and (last_name = 'LINTON')
group by c.customer_id,  first_name,  last_name,  title
order by count(*) desc;

/*16.Select all of the films where the length is longer
than the average of all films*/
select *
from film
where length > (select avg(length)
from film);

/*17.Return all the films that are available
in the inventory in store 2 more than 3 times*/
select *
from film
where film_id in (select film_id
from inventory
where store_id = 2
group by film_id
having count(*) > 3);

/*18.Return all customer first names and last names 
that have made payment on 2020-01-25*/
--cara 1 :
select distinct first_name,
last_name
from customer c
left join payment p
on c.customer_id = p.customer_id
where date(payment_date) in (select date(payment_date)
from payment
where date(payment_date) = '2020-01-25')
order by first_name;

--cara 2 :
select first_name,
last_name
from customer
where customer_id in (select customer_id
from payment
where date(payment_date) = '2020-01-25')
order by first_name;

/*19.Return all customer first name and email address
that have spent a more than $30*/
select first_name,
email
from customer
where customer_id in (select customer_id
from payment
group by customer_id
having sum(amount)>30);

/*20.Return all the customer first and last name
that are from California and have spent more than
100 in total*/
select first_name,
last_name
from customer
where customer_id in (select customer_id
	from payment
	group by customer_id
	having sum(amount)>100) 
and customer_id in (select customer_id
	from customer c
	inner join address a
	on c.address_id = a.address_id
	where district = 'California');
	
/*21.What is the average total amount spent per day
(average daily revenue)?*/
select round(avg(total_amount),2) as daily_rev_avg
from
(select date(payment_date),
sum(amount) as total_amount
from payment
group by date(payment_date)) as subquery;

/*22.Show all the payment together with how much
the payment amount is below the maximum payment amount*/
select *, (select max(amount) from payment) - amount as difference
from payment

/*23.Show only those movie titles, their associated film_id
and replacement _cost with the lowest replacement _cost 
for in each rating category - also show the rating*/
select title, 
film_id, 
replacement_cost,
rating
from film f1
where replacement_cost = (select min(replacement_cost)
						 from film f2
						 where f1.rating = f2.rating);
						 
/*24.Show only those movie titles, their associated film_id
and the length that have the highest length in each 
category - also show the rating*/
select title, 
film_id, 
length,
rating
from film f1
where length = (select max(length)
				  from film f2
				  where f1.rating = f2.rating);
				  
/*25.Show all the payments plus the total amount for every customer as 
well as the number of payments of each customer*/
select *,
(select sum(amount) as sum_amount
from payment p2
where p1.customer_id = p2.customer_id),
(select count(amount) as count_payment
 from payment p2
 where p1.customer_id = p2.customer_id)
from payment p1
order by customer_id, amount desc;

/*26.Show only those films with the highest replacement costs 
in their rating category plus show the average replacement cost 
in their rating category*/
select title,
replacement_cost,
rating,
(select avg(replacement_cost)
from film f2
where f1.rating = f2.rating)
from film f1
where replacement_cost = (select max(replacement_cost) as max_replace_cost
from film f3
where f1.rating = f3.rating);

/*27.Show only those payments with the highest payment for each 
customer's first name - including the payment_id of that payment.
How would you solve it if you would not need to see the payment_id?*/
select first_name, payment_id, amount
from payment p1
inner join customer c
on p1.customer_id = c.customer_id
where amount = (select max(amount)
			   from payment p2
			   where p1.customer_id = p2.customer_id);

/*28.Create a list of all the different (distinct) replacement costs 
of the films. What's the lowest replacement cost?*/
select distinct min(replacement_cost)
from film;

/*29.Write a query that gives an overview of how many films have 
replacements costs in the following cost ranges
low: 9.99 - 19.99
medium: 20.00 - 24.99
high: 25.00 - 29.99
How many films have a replacement cost in the "low" group?*/
select count(replacement_cost),
case when replacement_cost < 20 then 'low'
when replacement_cost < 25 then 'medium'
when replacement_cost < 30 then 'high'
end as category
from film
group by category;

/*30.Create a list of the film titles including their title, length, 
and category name ordered descendingly by length. 
Filter the results to only the movies in the category 'Drama' or 'Sports'.
In which category is the longest film and how long is it?*/
select title,
length,
c.name
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
where c.name in ('Drama','Sports')
order by length desc;

/*31.Create an overview of how many movies (titles) there are in 
each category (name).
Which category (name) is the most common among the films?*/
select count(title),
c.name
from film f
inner join film_category fc
on f.film_id = fc.film_id
inner join category c
on fc.category_id = c.category_id
group by c.name
order by count(title) desc;

/*32.Create an overview of the actors' first and last names and in 
how many movies they appear in.
Which actor is part of most movies?*/
select a.first_name,
a.last_name,
count(title)
from actor a
inner join film_actor fa
on a.actor_id = fa.actor_id
inner join film f
on fa.film_id = f.film_id
group by a.first_name,
a.last_name
order by count(title) desc;

/*33.Create an overview of the addresses that are not associated 
to any customer
How many addresses are that?*/
select count(*)
from address a
left join customer c 
on c.address_id = a.address_id
where first_name is null;

/*34.Create an overview of the cities and how much sales (sum of amount) 
have occurred there.
Which city has the most sales?*/
select city,
sum(amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
inner join address a
on c.address_id = a.address_id
inner join city ci
on a.city_id = ci.city_id
group by city
order by sum(amount) desc;

/*35. Create an overview of the revenue (sum of amount) grouped by a 
column in the format "country, city".
Which country, city has the least sales?*/
select city,
country,
sum(amount)
from payment p
inner join customer c
on p.customer_id = c.customer_id
inner join address a
on c.address_id = a.address_id
inner join city ci
on a.city_id = ci.city_id
inner join country co
on ci.country_id = co.country_id
group by city,
country
order by sum(amount) asc;

/*36.Create a list with the average of the sales amount each staff_id 
has per customer.
Which staff_id makes on average more revenue per customer?*/
select 
staff_id, 
avg(total) 
from(select staff_id,
customer_id,
sum(amount) as total
from payment p
group by staff_id,
customer_id)
group by staff_id

/*37.Create a query that shows average daily revenue of all Sundays.
What is the daily average revenue of all Sundays?*/
--cara 1
select avg(total_amount) 
from(select date(payment_date),
to_char(payment_date,'Day') as day,
sum(amount) as total_amount
from payment
where to_char(payment_date,'Day') = 'Sunday   '
group by date(payment_date),
to_char(payment_date,'Day'));

--cara 2
select avg(total_amount) 
from(select date(payment_date),
extract(dow from payment_date),
sum(amount) as total_amount
from payment
where extract(dow from payment_date) = 0
group by date(payment_date),
extract(dow from payment_date));

/*38.Create a list of movies - with their length and their replacement
cost - that are longer than the average length in each replacement 
cost group.
Which two movies are the shortest on that list and how long are they?*/
select title,
length,
replacement_cost
from film f1
where length >(select avg(length)
from film f2
where f1.replacement_cost = f2.replacement_cost)
order by length asc;

/*39. Create a list that shows the "average customer lifetime value" 
grouped by the different districts.
Example:
If there are two customers in "District 1" where one customer has 
a total (lifetime) spent of $1000 and the second customer has a total 
spent of $2000 then the "average customer lifetime spent" in this 
district is $1500.
So, first, you need to calculate the total per customer and then the 
average of these totals per district.
Which district has the highest average customer lifetime value?*/
select district,
avg(total)
from (select c.customer_id,
	district,
	sum(amount) as total
	from customer c
	inner join payment p1
	on c.customer_id = p1.customer_id
	inner join address a
	on c.address_id = a.address_id
	group by c.customer_id,
	district) as sub
group by district
order by avg(total) desc;

/*40.Create a list that shows all payments including the payment_id, 
amount, and the film category (name) plus the total amount that was 
made in this category. Order the results ascendingly by the category
(name) and as second order criterion by the payment_id ascendingly.
What is the total revenue of the category 'Action' and what is the 
lowest payment_id in that category 'Action'?*/
select title, 
amount,
payment_id,
name,
(select sum(amount)
from category c2
inner join film_category fc
on  c2.category_id = fc.category_id
inner join film f
on fc.film_id = f.film_id
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
inner join payment p
on r.customer_id = p.customer_id
where c1.name=c2.name)

from category c1
inner join film_category fc
on  c1.category_id = fc.category_id
inner join film f
on fc.film_id = f.film_id
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id
inner join payment p
on r.customer_id = p.customer_id
order by name asc, payment_id asc
limit 2;

/*41.create new table 'director'*/
create table director(
director_id serial primary key,
director_account_name varchar(20) unique,
first_name varchar(50),
last_name varchar(50) default 'Not specified',
date_of_birth date,
address_id int references address(address_id));

select *
from director;

/*41.alter director table to the following:
a. director_account_name to VARCHAR(30)
b. drop the default on last_name
c. add the constraint not null to last_name
d. add the column email of data type VARCHAR(40)
e. rename the director_account_name to account_name
6. rename the table from director to directors*/
alter table director
alter column director_account_name type VARCHAR(30),
alter column last_name drop default,
alter column last_name set not null,
add column email VARCHAR(40);

alter table director
rename column director_account_name to account_name;

alter table director
rename to directors;

select *
from directors

/*42. Insert into directors table for new director and
Update email from eren_yeager@gmail.com to shiganshina@gmail.com.
1. Add the column initials (data type varchar(10))
2. Update the values to the actual initials for example Frank Smith 
should be F.S.*/
--insert information :
insert into directors
(director_id, account_name, first_name, last_name, date_of_birth,
address_id, email)
values(1, 'eren_yeager', 'Eren', 'Yeager', '1835-03-30', 
	   1, 'eren_yeager@gmail.com');

--update email :
update directors
set email = 'shiganshina@gmail.com'
where email = 'eren_yeager@gmail.com';

--add column initials :
alter table directors
add column initials varchar(10);

--create initials:
update directors
set initials= upper(left(first_name,1)) ||'.' || 
upper(left(last_name,1)) ||'.'

select *
from directors

/*43.Write a query that returns the list of movies including
- film_id,
- title,
- length,
- category,
- average length of movies in that category.
Order the results by film_id.*/
select f.film_id,
title,
length,
name,
round(avg(length) over(partition by name),2)
from film f
left join film_category fc
on f.film_id = fc.film_id
left join category c
on fc.category_id = c.category_id
order by film_id;

/*44. Write a query that returns all payment details including
- the number of payments that were made by this customer
and that amount
Order the results by payment_id.*/
select *,
count(*) over (partition by customer_id, amount)
from payment
order by payment_id;

/*45.Rank number one position every film category*/
select *
from
(select title,
name,
length,
dense_rank() over(partition by name order by length desc)as rank
from film f
left join film_category fc
on f.film_id = fc.film_id
left join category c
on fc.category_id = c.category_id) as sub_query
where rank = 1

/*46. Write a query that returns the customers' name, the country and how many
payments they have. For that use the existing view customer_list.

Afterwards create a ranking of the top customers with most sales for each
country. Filter the results to only the top 3 customers per country.*/
select *
from
(select first_name || ' ' || last_name as name,
country,
count(amount),
dense_rank() over(partition by country order by count(amount) desc) as rank
from payment p
left join customer cu
on p.customer_id = cu.customer_id
left join address a
on cu.address_id = a.address_id
left join city as ci
on a.city_id = ci.city_id
left join country co
on ci.country_id = co.country_id
group by first_name || ' ' || last_name, country) as sub_query
where rank = 1
order by count desc
limit 3;

/*47. Write a query that returns the revenue of the day and the revenue of the
previous day.
Afterwards calculate also the percentage growth compared to the previous
day.*/
select sum(amount),
date(payment_date) as day,
lag(sum(amount)) over(order by date(payment_date)) as previous_day,
sum(amount) - lag(sum(amount)) over(order by date(payment_date)) as difference,
round((sum(amount) - lag(sum(amount)) over(order by date(payment_date)))
/
lag(sum(amount)) over(order by date(payment_date))*100,2) as percentage_growth
from payment
group by date(payment_date);

/*48. Write query that return the sum of the amount for each
customer (first name and last name) and each staff_id.
Also add the overall revenue per customer*/
select first_name,
last_name,
staff_id,
sum(amount)
from customer c
left join payment p
on c.customer_id = p.customer_id
group by
	grouping sets(
	(first_name, last_name),
	(first_name, last_name, staff_id))
order by 1;

/*49. Write a query that calculates now the share of revenue
each staff_id makes per customer.*/
select first_name,
last_name,
staff_id,
sum(amount) as total,
first_value(sum(amount)) over(
	partition by first_name, last_name 
	order by(sum(amount)) desc),
round(sum(amount) * 100 / first_value(sum(amount)) over(
	partition by first_name, last_name 
	order by(sum(amount)) desc),2) as percentage
from customer c
left join payment p
on c.customer_id = p.customer_id
group by
	grouping sets(
	(first_name, last_name),
	(first_name, last_name, staff_id));
	
/*50. Write a query that returns all grouping sets in all 
combinations of customer_id, date and title with the aggregation 
of the payment amount.*/
select p.customer_id,
date(payment_date),
title,
sum(amount) as total
from payment p
left join rental r
on p.customer_id = r.customer_id
left join inventory i
on r.inventory_id = i.inventory_id
left join film f
on i.film_id = f.film_id
group by
cube(p.customer_id,
date(payment_date),
title)
order by 1,2,3;

/*51. Find all the pairs of films with the same length*/
select f1.title,
f2.title,
f1.length
from film f1
left join film f2
on f1.length = f2.length
where
f1.title != f2.title
order by length desc;

/*52. Create a function that expects the customer's first and last name
and returns the total amount of payments this customer has made*/
--Function
create or replace function name_searchs(f_name varchar(20), l_name varchar(20))
returns decimal(6,2)
language plpgsql
as
$$
declare
payment_count decimal(6,2);
begin
select 
sum(amount)
into payment_count
from customer c
left join payment p
on c.customer_id = p.customer_id
where first_name = f_name and last_name = l_name;
return payment_count;
end;
$$

select name_searchs('AMY', 'LOPEZ')

--Cara Manual
select first_name,
last_name,
sum(amount)
from customer c
left join payment p
on c.customer_id = p.customer_id
where last_name = 'LOPEZ'
group by first_name,
last_name
