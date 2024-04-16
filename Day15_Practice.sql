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
