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

-4) CORRELATED SUBQUERIES IN WHERE (truy vẫn con tương quan)
--lấy ra thông tin khách hàng từ bảng customer có tổng hoá đơn >100$

SELECT customer.customer_id,
SUM (payment.amount) as total 
FROM customer
JOIN payment ON customer.customer_id=payment.customer_id
GROUP BY customer.customer_id
HAVING SUM (payment.amount) >100

SELECT * FROM customer
WHERE EXISTS  (SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM (amount)>100)

-5) CORRELATED SUBQUERIES IN SELECT
-5) CORRELATED SUBQUERIES IN SELECT
-- mã KH, tên KH, mã thanh toán, số tiền lớn nhất của từng KH
SELECT 
a.customer_id,
a.first_name || a.last_name as Ho_ten,
b.payment_id,
(SELECT MAX (amount) FROM payment 
 WHERE customer_id=a.customer_id -- ĐK where ở câu truy vấn con này
 GROUP BY customer_id)
FROM customer AS a -- tương ứng vs trường nào ở câu truy vấn chính
JOIN payment AS b
ON a.customer_id=b.customer_id
GROUP BY
a.customer_id,
a.first_name || a.last_name,
b.payment_id
ORDER BY customer_id
/* CHALLENGE 1 : video 4:47 
-Liệt kê các khoản thanh toaná với tổng số hoá đơn 
và tổng số tiền mỗi khách hàng phải trả */
CHƯA NÀM

/* CHALLENGE 2: video 5:27
- Lấy ds các film có chi phí thay thế lớn nhất trong mỗi loại rating.
Ngoài film_id, title,rating, chi phí thay thế cần hiển thị
thêm chi phí tr binh mỗi loại raitng đó. */

/* -6) CTEs (Common Table Expression):bảng chứa dữ liệu tạm thời
từ câu lệnh được định nghĩa trong phạm vi của nó
 -> chia nhỏ 1 câu lệnh SQL phức tạp thành các phần nhỏ hơn để giải quyết 
 -> gộp lại để giải quyết wde tổng thể 
 -cú pháp: WITH CTE name
           CTE body (có thể viết câu lệnh SELECT hoàn chỉnh)
           CTE usage (câu lệnh SELECT hoàn chỉnh)*

-- Tìm KH có nhiều hơn 30 hoá đơn, kqua trả ra gồm các tt:
-- mã Kh, tên KH, số lượng hoá đơn, tổng số tiền, tgian thuê tbinh */
-- Giải: với nhưng tt chưa có sẵn -> tạo CTE tính toán trước khi 
-- cho vào câu lệnh chính
WITH twt_total_payment AS
(SELECT customer_id,
COUNT (payment_id) AS so_luong,
SUM (amount) as so_tien
FROM payment
GROUP BY customer_id ),
twt_avg_rental_time
AS 
( SELECT customer_id, 
 AVG (return_date-rental_date) as rental_time
 FROM rental
 GROUP BY customer_id)
SELECT  a.customer_id, a.first_name,b.so_luong,b.so_tien,c.rental_time
FROM customer as a
JOIN twt_total_payment as b ON a.customer_id=b.customer_id
JOIN twt_avg_rental_time as c ON c. customer_id =a.customer_id
WHERE b.so_luong >30
