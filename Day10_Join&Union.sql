--1) INNER JOIN
-- CÚ PHÁP (table 1 INNER JOIN table 2)
SELECT t1.*, t2.* -- Hiển thị thông tin của bảng 1 và băng 2
FROM table1 AS t1 -- sau khi lấy bảng 1
INNER JOIN table2 AS t2 -- kết hợp/ghép nối vs bảng 2
ON t1.key1=t2.key2 --thông qua key join của bảng 1 và key join của bảng 2

SELECT distinct a.payment_id, a.customer_id,b.first_name,b.last_name 
FROM payment as a
INNER JOIN customer b
ON a.customer_id=b.customer_id
order by a.customer_id
-- 1.1. Challenge
--có bn ng chọn ghế ngồi theo các loại business, economy, comfort
