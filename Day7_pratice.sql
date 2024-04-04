--ex1
select name
from students
where marks >75
order by right (name,3), id asc
--ex2
SELECT
user_id,
-- cách 1: upper (LEFT (name,1)) || lower (right (name, length(name)-1)) as name
upper (LEFT (name,1)) || lower (substring (name from 2)) as name -- cách 2
from users
order by user_id
--ex3
SELECT manufacturer,
'$' || ROUND (SUM(total_sales)/1000000,0) || ' million' as sale
FROM pharmacy_sales
GROUP BY manufacturer
order by SUM(total_sales) desc
