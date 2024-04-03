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
