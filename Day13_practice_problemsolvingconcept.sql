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

-ex2
