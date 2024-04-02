--ex1
select distinct city from station where id%2=0
--ex2
SELECT COUNT(CITY) - COUNT(DISTINCT CITY) FROM STATION;
--ex4 
/* phân tích yêu cầu
1. output (gốc/ phái sinh) mean = tổng items/ tổng đơn hàng
2. input
3. đk lọc theo trường nào (gốc hay phái sinh)*/
SELECT ROUND(CAST(SUM(item_count*order_occurrences) / SUM(order_occurrences)as decimal),1) as mean
FROM items_per_order;
--ex5
/* ptich yêu cầu
1. output (gốc/ phái sinh) candidate_id
2. input: 
3. đk lọc theo trường nào (gốc hay phái sinh): */
SELECT candidate_id
FROM candidates
WHERE skill IN ('Python','Tableau','PostgreSQL')
GROUP BY (candidate_id)
having COUNT(skill) =3
--ex6 
/* ptich yêu cầu
1. output (gốc/ phái sinh) user_id, days_between=max(day) -min(day)
2. input:
3. đk lọc theo trường nào (gốc hay phái sinh): */
SELECT user_id,
DATE (MAX (post_date)) - DATE(MIN (post_date)) as days_between
FROM posts
WHERE post_date>='2021-01-01' and post_date<='2022-01-01'
group by user_id
having COUNT(post_id)>=2
--ex7
select card_name,
max(issued_amount)-min(issued_amount) as difference
from monthly_cards_issued
group by card_name
order by difference DESC
--ex8
/* ptich yêu cầu
1. output (gốc/ phái sinh) manufacturer,drug_count,total_loss
2.input
3. đk lọc theo trường nào (gốc hay phái sinh):total_sales<cogs */
SELECT manufacturer,
COUNT(drug) AS drug_count,
ABS(SUM(cogs-total_sales))as total_loss
FROM pharmacy_sales
where total_sales< cogs
group by manufacturer
order by total_loss desc
--ex9
/* phân tích yêu cầu
1. output (gốc/ phái sinh) id | movie      | description | rating
2. input
3. đk lọc theo trường nào (gốc hay phái sinh):odd ID,descrip not borring rating desc*/ 
select * from cinema
where id%2=1 and description<>'boring'
order by rating desc
--ex10
select teacher_id,
count (distinct subject_id) as cnt
from teacher
group by teacher_id
--ex11
select user_ID,
count (follower_id) as followers_count
from followers
group by user_id
order by user_id
--ex12
select class from courses
group by class
having count (student) >=5


