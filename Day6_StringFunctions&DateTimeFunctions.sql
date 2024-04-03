-- LOWER, UPPER, LENGTH
SELECT email, 
lower (email) as lower_email,
upper (email) as upper_EMAIL,
length (email) as length_email
FROM customer
WHERE length (email)>30
--CHALLENGE: liệt kê kh có họ/tên >10 ký tự chữ thường
SELECT 
lower (last_name) as last_name,
lower (first_name) as first_name
from customer
where length (last_name) >10 or length (first_name) >10
-- LEFT () - RIGHT ()
SELECT first_name,
RIGHT (LEFT (first_name,3),2)
from customer
---CHALLENGE
select email, 
left (right (email,4),1)
from customer
-- CONCATENATE (Nối chuỗi)
SELECT
customer_ID,
first_name,
last_name,
-- first_name ||' '|| last_name as FUll_NAME -- || dùng để nối chuỗi
CONCAT(first_name,' ',last_name) AS full_name
FROM customer
/* CHALLENGE nỗi chuỗi 
MARY.SMITH@sakilacustomer.org => MAR***H@sakilacustomer.org */
select email,
LEFT (email,3) || '***' || RIGHT (email,20)
from customer
-- REPLACE
SELECT email,
REPLACE (email, '.org','.com') AS new_email
FROM customer
-- ex3 of practice 5
select CEILING (AVG(salary) - avg(REPLACE (salary,'0','')))
from employee
-- POSITION
SELECT email,
LEFT (email,(POSITION  ('@' IN email))-1)
FROM customer
-- 6) SUBSTRING()
-- lấy ra ký tự từ 2 đến 4 của first_name trong bảng customer
SELECT first_name,
SUBSTRING(first_name FROM 2 FOR 3) 
FROM customer
-- lấy thông tin họ KH từ email
select email, 
substring (email from position ('.'IN email) + 1  for position ('@'in email) - position ('.' IN email)-1) as HO_KH
FROM customer
*/
SELECT email,
SUBSTRING(email FROM POSITION ( '.' IN email) +1 FOR POSITION ( '@' IN email)-POSITION ( '.' IN email)-1) as HO_KH
FROM customer 
-- 7) EXTRACT() dùng để trích xuất thông tin Năm, tháng, ngày, giờ.. của 1 date/datetime kết quả trả ra dưới dạng number
SELECT * FROM rental
WHERE EXTRACT( 'year' FROM rental_date) =2020
-- 8) TO_CHAR () lấy thông tin datetime theo định dạng momg muốn(forrmat) 
SELECT TO_CHAR(payment_date, 'year') 
FROM payment
-- 9) Intervals & Timestamp
SELECT current_date,--ngày hiện tại
current_timestamp, -- ngày giờ hiện tại
returndate-rental_date AS rental_time -- là 1 interval
-- challenge 

select rental_date,return_date, customer_ID,
return_date-rental_date AS rental_time
from rental
WHERE customer_id =35

SElect customer_id,
AVG (return_date-rental_date) AS avg_rental_time
from rental
GROUP BY customer_ID
ORDER BY customer_ID desc
