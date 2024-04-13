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
output: category,	product,	total_spend
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

