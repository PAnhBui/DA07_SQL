-1)SUBQUERIES IN WHERE
-- Tìm những hoá đơn có số tiền lớn hơn số tiền trung bình các hoá đơn
-- b1: tính tiền tbinh các hoá đơn : select avg(amount) from payment
SELECT * From payment
where amount > (select avg(amount) from payment); -- subqueries

--tìm những hoá đơn của khách hàng có tên là Adam
-- b1: tìm mã khách hàng của tên adam
-- SELECT customer_id FROM customerWHERE firsT_name ='ADAM'
 SELECT * FROM payment
WHERE customer_id=(SELECT customer_id FROM customer
WHERE firsT_name ='ADAM')
 
-- CHALLENGE: 1)tìm những film có thời lượng lớn trung bình các bộ phim
SELECT film_id,title FROM film
WHERE length > (SELECT avg (length) from film)
  
----ch 2) tìm những film có ở store 2 ít nhất 3 lần
SELECT film_id, title
FROM film
WHERE film_id IN (SELECT film_id
FROM public.inventory
WHERE store_id = 2
GROUP BY film_id 
HAVING count (film_id) >=3)

---ch3) tìm những KH đến từ california , đã chi tiêu nhiều hơn 100
SELECT customer_id,first_name,last_name,email 
FROM customer
WHERE customer_id IN (SELECT customer_id FROM payment
group by customer_id having sum(amount)>100)
  
-2)SUBQUERIES IN FROM 
-- TÌM những KH có nhiều hơn 30 đơn hàng
SELECT * FROM 
(SELECT customer_id,
COUNT (payment_id) as so_luong
FROM payment
GROUP BY customer_id) as new_table
WHERE so_luong >30
-- TÌM TÊN CỦA NHỮNG KH CÓ NHIỀU HƠN 30 ĐƠN HÀNG
SELECT customer.first_name, new_table.so_luong FROM 
(SELECT customer_id,
COUNT (payment_id) as so_luong
FROM payment
GROUP BY customer_id) as new_table
INNER JOIN customer ON new_table.customer_id=customer.customer_id
WHERE so_luong >30

-3) SUBQUERIES IN SELECT

SELECT *, 
(SELECT AVG(amount) FROM payMENT)
from payment

--Challenge: Tìm chênh lệch giữa số tiền từng hoá đơn so với số tiền thanh 
-- toán lớn nhất mà cty nhận được
SELECT payment_id,amount, 
(SELECT MAX(amount) FROM payment) as Max_amount, (SELECT MAX(amount) FROM payment) - amount as diff
FROM payment

