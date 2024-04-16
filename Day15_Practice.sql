/* ex1: output 
year - ascending order,
product_id	curr_year_spend	prev_year_spend	yoy_rate -> rounded to 2 decimal places.
DK:each product, grouping the results by product ID.*/
WITH twt_yearly_spend AS (
SELECT 
extract (year from transaction_date) as year,
product_id,
spend as curr_year_spend,
LAG(spend) OVER (PARTITION BY product_id ORDER BY product_id, 
EXTRACT(YEAR FROM transaction_date)) AS prev_year_spend 
FROM user_transactions
)
SELECT *,
ROUND((curr_year_spend-prev_year_spend)/prev_year_spend*100,2) as yoy_rate
FROM  twt_yearly_spend
  
/* ex2:
-output: card_name| issued_amount
DK : issued in its launch month, desc issued amount.*/

SELECT 
Distinct card_name,
FIRST_VALUE (issued_amount) OVER 
(PARTITION BY card_name ORDER BY issue_year,issue_month) as issued_amount
FROM monthly_cards_issued
ORDER BY issued_amount desc

/* ex3:
-output:user_id	spend	transaction_date
dk third transaction of every use */

WITH twt_order AS (
SELECT *, 
ROW_NUMBER () OVER (PARTITION BY user_id ORDER BY transaction_date) as num
FROM transactions )
SELECT user_id,	spend,	transaction_date
FROM twt_order
WHERE num=3

/* ex4:
-output: user's most recent transaction date
user_id	
purchase_count
-DK: sorted in chronological order by date.*/
WITH twt_latest_transactions AS (
SELECT transaction_date, user_id,
product_id,
RANK () OVER (PARTITION BY user_id ORder by transaction_date DESC ) as rank
FROM user_transactions
)
SELECT transaction_date, user_id,COUNT (product_id) as purchase_count
FROM twt_latest_transactions
WHERE rank =1
GROUP BY transaction_date, user_id
ORDER BY transaction_date;

--ex5:
WITH cte AS (
SELECT 
  user_id,
  tweet_date,
  tweet_count,
  LAG(tweet_count,1) OVER(PARTITION BY user_id) AS tweet_old_1,
  LAG(tweet_count,2) OVER(PARTITION BY user_id) AS tweet_old_2
FROM tweets)
SELECT 
  user_id,
  tweet_date, 
  CASE 
    WHEN tweet_old_1 IS NULL THEN ROUND(tweet_count/1.0, 2)
    WHEN tweet_old_2 IS NULL THEN ROUND((tweet_count + tweet_old_1)/2.0, 2)
    ELSE ROUND((tweet_count + tweet_old_1 + tweet_old_2)/3.0, 2)
  END rolling_avg_3d
FROM cte

--ex6
WITH payments AS (
  SELECT merchant_id, 
  EXTRACT(EPOCH FROM transaction_timestamp - 
  LAG(transaction_timestamp) OVER( PARTITION BY merchant_id, credit_card_id, amount 
  ORDER BY transaction_timestamp) )/60 AS minute_diff 
  FROM transactions) 

SELECT COUNT(merchant_id) AS payment_count
FROM payments 
WHERE minute_diff <= 10
  
--ex7:
WITH spending_cte AS (
SELECT category, product,
SUM(spend) AS total_spend,
RANK() OVER ( PARTITION BY category ORDER BY SUM(spend) DESC) AS rank
FROM product_spend
WHERE EXTRACT(year from transaction_date) =2022
GROUP BY category, product
 )
SELECT category, 
product, total_spend 
FROM spending_cte
WHERE rank <= 2 
ORDER BY category, rank

/*ex8: find the top 5 artists appear Top 10 of the global_song_rank table
-output: artist_name	artist_rank

*/
WITH top_10_songs AS (
SELECT a.artist_name, 
DENSE_RANK() OVER (ORDER BY COUNT(b.song_id) DESC) AS artist_rank
FROM artists a 
JOIN songs b ON a.artist_id=b.artist_id
JOIN global_song_rank c ON b.song_id=c.song_id
WHERE c. rank <=10
GROUP BY a.artist_name
)
SELECT artist_name, artist_rank
FROM top_10_songs
WHERE artist_rank <= 5


