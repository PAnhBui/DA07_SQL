--ex1
Select a.Continent, 
FLOOR (AVG (b.Population)) as avg_population
FROM  COUNTRY  AS a
INNER JOIN CITY AS b -- tại sao ko dùng được LEFT JOIN ạ?
ON  b.CountryCode=a.Code
GROUP BY a.Continent
--ex2
SELECT 
  ROUND( cast (COUNT(b.email_id)/COUNT(DISTINCT a.email_id) as decimal),2) AS confirm_rate
FROM emails as a
LEFT JOIN texts as b
  ON a.email_id = b.email_id
  AND b.signup_action = 'Confirmed';
--ex3 -CÂU NÀY EM TRA ĐÁP ÁN do DO ÁP DỤNG CHƯA RA ĐÁP ÁN
WITH snaps_statistics AS (
  SELECT 
    age.age_bucket, 
    SUM(CASE WHEN activities.activity_type = 'send' 
      THEN activities.time_spent ELSE 0 END) AS send_timespent, 
    SUM(CASE WHEN activities.activity_type = 'open' 
      THEN activities.time_spent ELSE 0 END) AS open_timespent, 
    SUM(activities.time_spent) AS total_timespent 
  FROM activities
 INNER JOIN age_breakdown AS age 
    ON activities.user_id = age.user_id 
  WHERE activities.activity_type IN ('send', 'open') 
  GROUP BY age.age_bucket) 

SELECT 
  age_bucket, 
  ROUND(100.0 * send_timespent / total_timespent, 2) AS send_perc, 
  ROUND(100.0 * open_timespent / total_timespent, 2) AS open_perc 
FROM snaps_statistics;
--ex4

SELECT a.customer_id
FROM customer_contracts as a
JOIN products as b
ON a.product_id=b.product_id
WHERE b.product_category	IN ('Containers','Analytics','Compute')
GROUP BY (a.customer_id)
having COUNT(DISTINCT b.product_category) =3
--EX5 
SELECT 
  mgr.employee_id, 
  mgr.name, 
  COUNT(emp.employee_id) AS reports_count, 
  ROUND( AVG(emp.age)) AS average_age 
FROM 
  employees AS emp 
  JOIN employees AS mgr ON emp.reports_to = mgr.employee_id 
GROUP BY mgr.employee_id, mgr.name
ORDER BY mgr.employee_id

--EX6
select a.product_name, SUM (b.unit ) as unit
from Products as a
LEFT JOIN Orders as b
ON a.product_id = b.product_id
WHERE EXTRACT(month from b.order_date) = 2 AND EXTRACT(year from b.order_date) =2020
GROUP BY a.product_name
HAVING SUM (b.unit ) >=100

--ex7 
SELECT 
a.page_id
FROM pages as a
LEFT JOIN page_likes as b
ON a.page_id=b.page_id
WHERE liked_date is NULL
ORDER BY a.page_id

-MID-COURSE TEST
--Q1
-- Task
SELECT DISTINCT replacement_cost
FROM film 
-- Question: 
SELECT MIN (DISTINCT replacement_cost)
FROM film 
--Q2
SELECT
CASE 
    WHEN replacement_cost BETWEEN 9.99 AND 19.99 then 'low'
    WHEN  replacement_cost BETWEEN 20.00 AND 24.99 then 'medium'
    ELSE 'high'
END AS category,
COUNT(*) AS so_luong
FROM film
GROUP BY category
--Q3
SELECT
a.title, a.length , c.name as category_name
FROM film as a
JOIN film_category as b ON a.film_id=b.film_id
JOIN category as c ON b.category_id=c.category_id
WHERE c.name IN ('Drama','Sports')
ORDER BY a.length DESC

--Q4
SELECT c.name as category_name, COUNT (title) as quantity
FROM film as a
JOIN film_category as b ON a.film_id=b.film_id
JOIN category as c ON b.category_id=c.category_id
GROUP BY c.name
ORDER BY quantity desc --Thể loại danh mục phổ biến nhất

--Q5
SELECT a.first_name, a.last_name , COUNT (b.film_id) as movies
FROM actor as a
JOIN film_actor as b ON a.actor_id=b.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY movies DESC

--Q6
SELECT COUNT (a.address_id)
from public.address as a 
LEFT JOIN  customer as b
ON a.address_id=b.address_id
WHERE b.customer_id is NULL



