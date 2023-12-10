# SQL Project Greencycles Online Movie Rental Shop Data Analysis Using PostgreSQL

## Project Description

**Problem :**  
**Inventory Management**  
Ensuring the availability of popular movies and managing inventory effectively

**Challenges :**  
Help the company operate big query and gain insight from data.

## Project Goal

Optimize the movie catalog by identifying and promoting popular content, while efficiently managing licensing costs to maximize profitability

## Tools & Library Used

[<img src="./image/postgresql-logo.png" alt="python-logo" width="50"/>](https://www.postgresql.org/) &nbsp;

## Project Result

[Click here to get full code](https://github.com/nickenshidqia/Online_Movie_Rental_Shop_Data_Analysis_SQL_Project/blob/9ab5a4d2b8f69a7341c924b5952b23026e0bfff8/SQL%20Project%20Greencycle%20Movie%20Rental%20Company.sql)

## Query Task

1. In the email system there was a problem with names where either the first name or the last name is more than 10 characters long. Find these customers and output the list of these first and last names in all lower case  
   <img src="./image/1.png" alt="" width = "350"/>
2. Extract the last 5 characters of the email address first. The email address always ends with '.org’. How can you extract just the dot '.' from the email address?  
   <img src="./image/2.png" alt="" width = "150"/>
3. You need to create an anonymized version of the email addresses. It should be the first character followed by '\*\*\*' and then the last part starting with '@'.  
   <img src="./image/3.png" alt="" width = "150"/>
4. In this challenge you have only the email address and the last name of the customers. You need to extract the first name from the email address and concatenate it with the last name. It should be in the form: "Last name, First name".
   <img src="./image/4.png" alt="" width = "400"/>
5. You need to create an anonymized form of the email addresses  
   <img src="./image/5.png" alt="" width = "300"/>
6. What's the highest amount one customer has spent in a week?  
   <img src="./image/6.png" alt="" width = "200"/>
7. You need to sum payments and group in the following formats  
   <img src="./image/7.png" alt="" width = "150"/>
8. You need to create a list for the suppcity team of all rental
   durations of customer with customer_id 35. Also you need to find out for the suppcity team which customer has the longest average rental duration?  
   <img src="./image/8.png" alt="" width = "200"/>
9. Your manager is thinking about increasing the prices for films that are more expensive to replace. Create a list of the films including the relation of rental rate where the rental rate is less than 4% of the replacement cost.  
   <img src="./image/9.png" alt="" width = "150"/>
10. a. Rating is 'PG' or 'PG-13' or length is more then 210 min: 'Great rating or long (tier 1)
    b. Description contains 'Drama' and length is more than 90min: 'Long drama (tier 2)’
    c. Description contains 'Drama' and length is not more than 90min: 'Shcity drama (tier 3)’
    d. Rental_rate less than $1: 'Very cheap (tier 4)’
    How can you filter to only those movies that appear in one of these 4 tiers?  
     <img src="./image/10.png" alt="" width = "300"/>
11. sum rating by category but in pivot table  
    <img src="./image/11.png" alt="" width = "300"/>
12. Handling missing value in return_date from rental table with 'Not returned'  
    <img src="./image/12.png" alt="" width = "250"/>
13. The company wants to run a phone call campaing on all customers in Texas (=district). What are the customers (first_name, last_name, phone number and their district) from Texas?  
    <img src="./image/13.png" alt="" width = "250"/>
14. The company wants customize their campaigns to customers depending on the country they are from.
    Which customers are from Brazil?  
     <img src="./image/14.png" alt="" width = "400"/>
15. Which title has GEORGE LINTON rented the most often?  
    <img src="./image/15.png" alt="" width = "400"/>
16. Select all of the films where the length is longer than the average of all films  
    <img src="./image/16.png" alt="" width = "700"/>
17. Return all the films that are available un the inventory in store 2 more than 3 times  
    <img src="./image/17.png" alt="" width = "700"/>
18. Return all customer first names and last names
    that have made payment on 2020-01-25  
     <img src="./image/18.png" alt="" width = "200"/>
19. Return all customer first name and email address that have spent a more than $30  
    <img src="./image/19.png" alt="" width = "300"/>
20. Return all the customer first and last name
    that are from California and have spent more than
    100 in total  
     <img src="./image/20.png" alt="" width = "170"/>
21. What is the average total amount spent per day (average daily revenue)?  
    <img src="./image/21.png" alt="" width = "120"/>
22. Show all the payment together with how much the payment amount is below the maximum payment amount  
    <img src="./image/22.png" alt="" width = "600"/>
23. Show only those movie titles, their associated film_id and replacement \_cost with the lowest replacement \_cost for in each rating category - also show the rating  
    <img src="./image/23.png" alt="" width = "700"/>
24. Show only those movie titles, their associated film_id
    and the length that have the highest length in each
    category - also show the rating  
     <img src="./image/24.png" alt="" width = "350"/>
25. Show all the payments plus the total amount for every customer as well as the number of payments of each customer  
    <img src="./image/25.png" alt="" width = "700"/>
26. Show only those films with the highest replacement costs in their rating category plus show the average replacement cost in their rating category  
    <img src="./image/26.png" alt="" width = "500"/>
27. Show only those payments with the highest payment for each customer's first name - including the payment_id of that payment. How would you solve it if you would not need to see the payment_id?  
    <img src="./image/27.png" alt="" width = "270"/>
28. Create a list of all the different (distinct) replacement costs of the films. What's the lowest replacement cost?  
    <img src="./image/28.png" alt="" width = "100"/>
29. Write a query that gives an overview of how many films have replacements costs in the following cost ranges
    low: 9.99 - 19.99
    medium: 20.00 - 24.99
    high: 25.00 - 29.99
    How many films have a replacement cost in the "low“ group?  
     <img src="./image/29.png" alt="" width = "170"/>
30. Create a list of the film titles including their title, length, and category name ordered descendingly by length. Filter the results to only the movies in the category 'Drama' or 'Sports’. In which category is the longest film and how long is it?  
    <img src="./image/30.png" alt="" width = "300"/>
31. Create an overview of how many movies (titles) there are in each category (name). Which category (name) is the most common among the films?  
    <img src="./image/31.png" alt="" width = "170"/>
32. Create an overview of the actors' first and last names and in
    how many movies they appear in. Which actor is part of most movies?  
     <img src="./image/32.png" alt="" width = "250"/>
33. Create an overview of the addresses that are not associated
    to any customer How many addresses are that?  
     <img src="./image/33.png" alt="" width = "100"/>
34. Create an overview of the cities and how much sales (sum of amount) have occurred there. Which city has the most sales?  
    <img src="./image/34.png" alt="" width = "300"/>
35. Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city". Which country, city has the least sales?  
    <img src="./image/35.png" alt="" width = "400"/>
36. Create a list with the average of the sales amount each staff_id has per customer. Which staff_id makes on average more revenue per customer?  
    <img src="./image/36.png" alt="" width = "250"/>
37. Create a query that shows average daily revenue of all Sundays. What is the daily average revenue of all Sundays?  
    <img src="./image/37.png" alt="" width = "200"/>
38. Create a list of movies - with their length and their replacement cost - that are longer than the average length in each replacement cost group. Which two movies are the shortest on that list and how long are they?  
    <img src="./image/38.png" alt="" width = "400"/>
39. Create a list that shows the "average customer lifetime value" grouped by the different districts.  
    <img src="./image/39.png" alt="" width = "300"/>
40. Write a query that returns the list of movies including film_id,, title, length, category, average length of movies in that category. Order the results by film_id.  
    <img src="./image/43.png" alt="" width = "400"/>
41. Write a query that returns all payment details including the number of payments that were made by this customer and that amount  
    <img src="./image/44.png" alt="" width = "500"/>
42. Rank number one position every film category  
    <img src="./image/45.png" alt="" width = "300"/>
43. Write a query that returns the customers' name, the country and how many payments they have. For that use the existing view customer_list. Afterwards create a ranking of the top customers with most sales for each
    country. Filter the results to only the top 3 customers per country  
     <img src="./image/46.png" alt="" width = "300"/>
44. Write a query that returns the revenue of the day and the revenue of the previous day. Afterwards calculate also the percentage growth compared to the previous
    day  
     <img src="./image/47.png" alt="" width = "400"/>
45. Write query that return the sum of the amount for each customer (first name and last name) and each staff_id. Also add the overall revenue per customer  
    <img src="./image/48.png" alt="" width = "300"/>
46. Write a query that calculates now the share of revenue
    each staff_id makes per customer  
     <img src="./image/49.png" alt="" width = "500"/>
47. Write a query that returns all grouping sets in all
    combinations of customer_id, date and title with the aggregation of the payment amount.  
     <img src="./image/50.png" alt="" width = "400"/>
