-- 1) CASE-WHEN
-- cú pháp
SELECT 
CASE
 WHEN codition1 THEN result1
 WHEN codition2 THEN result2
 ..
 ELSE resultn
FROM table_nm
/* EXAMPLE: Hãy phân loại các bộ phim theo thời lượng short-medium-long cụ thể:
- short : <60 phút
- medium: 60 -120 phút
- long: > 120 phuts 
=> CASE 
        WHEN... THEN
    END ;*/
select film_id,
CASE
    WHEN length <60 THEN 'short'
	WHEN length BETWEEN 60 AND 120 THEN 'medium'
	WHEN length > 120 THEN 'long' -- ELSE 'long'
END category
FROM film
-- với mỗi category có bn phim
select
CASE
    WHEN length <60 THEN 'short'
	WHEN length BETWEEN 60 AND 120 THEN 'medium'
	ELSE 'long'
END category,
COUNT (*) AS so_luong
FROM film
GROUP BY category
/* bộ phim có tag là 1 nếu rating là G hoặc PG
tag là 0 trong các TH còn lại */
Select film_id,
CASE 
    WHEN rating IN ('PG','G') THEN 1
	ELSE 0
END TAG
from film
