--WINDOW FUNCTIONS WITH hàm tổng hợp
-OVER() with PARTITION BY
/*ex: Tính tỉ lệ số tiền thanh toán từng ngày với tổng số tiền đã thanh toán của mỗi KH
output: mã KH, tên KH, ngày thanh toán, số tiền thanh toán tại ngày, 
tổng số tiền đã thanh toán, tỷ lệ */
-- cách cũ phức tạp --
--SUBQUERIES
SELECT a.customer_id,b.first_name, a.payment_date, a.amount,
(SELECT SUM (AMOUNT) FROM payment x WHERE x.customer_id=a.customer_id),
a.amount/(SELECT SUM (AMOUNT) FROM payment x WHERE x.customer_id=a.customer_id)*100.00 as ty_le
FROM payment AS a
JOIN customer AS b ON a.customer_id=b.customer_id
GROUP BY a.customer_id,b.first_name, a.payment_date, a.amount;

-CTE: trường nào chưa có thì để riêng sang 1 CTE
WITH twt_total_payment AS
(SELECT customer_id, SUM (amount) AS total FROM payment GROUP BY customer_id)
SELECT a.customer_id,b.first_name, a.payment_date, a.amount, c.total,
  a.amount/c.total as ty_le
FROM payment AS a
JOIN customer AS b ON a.customer_id=b.customer_id
JOIN twt_total_payment c ON c.customer_id=a.customer_id

--Window function
SELECT a.customer_id,b.first_name, a.payment_date, a.amount,
SUM (amount) OVER (PARTITION BY a.customer_id) AS total
FROM payment AS a
JOIN customer AS b ON a.customer_id=b.customer_id

--cú pháp
SELECT col1,col2,col3,...
AGG(col2) OVER (PARTITION BY col1,col2) AS x
FROM table_name

/*CHALLENGE: 
1.1. Viết truy vấn về danh sách phim bao gồm -film_id, -title, length, category,
- thời lượng trung bình của phim trong category đó.
Sắp xếp kết quả theo film_id*/
SELECT a.film_id,a.title,a.length,c.name as category,
AVG (a.length) OVER (PARTITION BY c.name) AS avg_length
FROM film a
JOIN public.film_category b ON a.film_id=b.film_id
JOIN public.category c ON c.category_id=b.category_id
ORDER BY a.film_id
/*1.2. Truy vân trả về tất cả chi tiết các thanh toán bao gồm số
lần thanh toán được thực hiện bởi khách hàng này và số tiền đó
Sx kq theo Payment_id
*/
SELECT *,
COUNT (*) OVER(PARTITION BY amount, customer_id)
FROM payment
ORDER BY payment_id
  
-OVER() with ORDER BY
-- cú pháp:
  SELECT col1,col2,...,
  AGG(col2) OVER (PARTITION BY col1,col2,...ORDER BY col4)
  FROM table_name
-tính luỹ kế tổng doanh thu từ thời điẻm trước đấy đến thời điểm hiện tại
SELECT payment_date,AMOUNT,
SUM (amount) OVER (ORDER BY payment_date) as total_amount
FROM payment

- phân nhóm theo từng KH
SELECT payment_date,amount,customer_id,
SUM (amount) OVER (PARTITION BY customer_id ORDER BY payment_date) as total_amount
FROM payment

-- WINDOW FUNCTION with RANK FUNCTION
--xếp hạng độ dài phim trong từng thể loại
--outptut:film_id,category, length, xếp hạng độ dài phim trong từng cate
SELECT a.film_id,a.length,c.name as category,
  RANK () OVER (PARTITION BY c.name ORDER BY a.length DESC) as rank
FROM film a
JOIN public.film_category b ON a.film_id=b.film_id
JOIN public.category c ON c.category_id=b.category_id
/*Challenge: viết truy vấn trả về tên KH, QG, so lg thanh toán họ có
- TẠo bảng xếp hạng những KH có doanh thu cao nhất cho mỗi QG
- Lọc KQ chỉ 3 KH hàng đầu của mỗi QG*/



