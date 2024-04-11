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
