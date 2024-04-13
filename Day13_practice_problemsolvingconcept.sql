--ex1 /*output: companies , 
đk: 2 job id share the same company id with title & descrip
b1: tạo bảng tìm mỗi cty có bn job
b2: đếm cty có job bị lặp
*/
WITH cte_table as (
  SELECT company_id, title, description, 
  COUNT(job_id) AS job_count
  FROM job_listings
  GROUP BY company_id, title, description)

SELECT COUNT(DISTINCT company_id) AS duplicate_companies
FROM cte_table
WHERE job_count > 1;

-ex2/*
output: category,	product,total_spend
dk: top 2 highest-grossing product within each category 2022.*/

WITH spending_cte AS (
SELECT category, 
product,
SUM(spend) AS total_spend,
RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking
FROM product_spend
WHERE EXTRACT(year from transaction_date) =2022
GROUP BY category, product
)
SELECT category, 
product, total_spend 
FROM spending_cte
WHERE ranking <= 2 
ORDER BY category, ranking;

--ex3
WITH call_records AS (
SELECT
  policy_holder_id,
  COUNT(case_id) AS call_count
FROM callers
GROUP BY policy_holder_id
HAVING COUNT(case_id) >= 3
)
SELECT COUNT(policy_holder_id) AS member_count
FROM call_records;

--ex4
SELECT 
a.page_id
FROM pages as a
LEFT JOIN page_likes as b
ON a.page_id=b.page_id
WHERE liked_date is NULL
ORDER BY a.page_id
--ex5
ELECT 
  EXTRACT(MONTH FROM curr_month.event_date) AS month, 
  COUNT(DISTINCT curr_month.user_id) AS monthly_active_users 
FROM user_actions AS curr_month
WHERE EXISTS (
  SELECT last_month.user_id 
  FROM user_actions AS last_month
  WHERE last_month.user_id = curr_month.user_id
    AND EXTRACT(MONTH FROM last_month.event_date) =
    EXTRACT(MONTH FROM curr_month.event_date - interval '1 month')
)
  AND EXTRACT(MONTH FROM curr_month.event_date) = 7
  AND EXTRACT(YEAR FROM curr_month.event_date) = 2022
GROUP BY EXTRACT(MONTH FROM curr_month.event_date);

--ex6
SELECT 
EXTRACT (YEAR from  trans_date)||' - '|| EXTRACT (month from  trans_date) as month,
country,
COUNT (State) as trans_count,
SUM (CASE WHEN state ='approved' then 1 else 0 end) as approved_count, 
SUM (amount) as trans_total_amount,
SUM (CASE WHEN state ='approved' then amount else 0 end) as approved_total_amount
FROM Transactions
GROUP BY month, country
ORDER BY month

--ex7
SELECT product_id, year AS first_year, quantity, price
FROM Sales
WHERE (product_id, year) in 
    (SELECT product_id, MIN(year) 
    FROM Sales
    GROUP BY product_id)

--ex8
SELECT customer_id 
FROM Customer 
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product);

--EX9
SELECT emp.employee_id
froM Employees AS Emp
LEFT JOIN employees as mng
on emp.manager_id=mng.employee_id
WHERE emp.salary<30000 AND mng.employee_id is NULL

-EX10: duplicate w/ exx1

--ex11:
(SELECT name AS results
FROM MovieRating JOIN Users USING(user_id)
GROUP BY name
ORDER BY COUNT(*) DESC, name
LIMIT 1)
UNION ALL
(SELECT title AS results
FROM MovieRating JOIN Movies USING(movie_id)
WHERE EXTRACT(YEAR FROM created_at) = 2020 AND EXTRACT(MONTH FROM created_at) =02
GROUP BY title
ORDER BY AVG(rating) DESC, title
LIMIT 1);

--ex12
with cte as
    (select requester_id as id from RequestAccepted
        union all
        select accepter_id as id from RequestAccepted)
select id, count(id) as num
from cte
group by id
order by num desc
limit 1

