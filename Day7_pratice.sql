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
--ex4
SELECT 
extract(month from submit_date) as mth,
product_id,
round (avg (stars),2) as avg_stars
FROM reviews
GROUP BY mth, product_id
ORDER BY mth, product_id
--ex5
SELECT 
sender_id,
count (message_id) as message_count
FROM messages
WHERE extract(month from 	sent_date) = 8
and extract(year from sent_date) = 2022
group by sender_id
order by message_count desc
limit 2
--ex6
select
tweet_id
from Tweets
where length (content) >15
--ex7
select
activity_date as day,
count (distinct  user_id) as active_users 
from Activity
WHERE (activity_date > '2019-06-27' AND activity_date <= '2019-07-27')
group by day
--ex8
select 
count (id) as number_of_employees
from employees
where extract (month from joining_date) between 1 and 7 and extract (year from joining_date) =2022
--ex9
select 
position ('a' in First_name)
from worker
where first_name = 'Amitah' 
--ex10

select 
substring (title,length(winery) +2,4 ) as the_year
from winemag_p2
where country ='Macedonia'

