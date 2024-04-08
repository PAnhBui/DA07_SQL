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
--ex3
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

