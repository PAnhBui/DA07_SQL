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
SELECT S.fare_conditions,
Count (flight_id) as Count
from bookingS.boarding_passes as F
INNER JOIN bookings.seats as S
ON F.seat_no=S.seat_no
group by S.fare_conditions
-- LEFT JOIN/ RIGHT JOIN
--- CÚ PHÁP (table1 LEFT JOIN table 2)
SELECT t1.*,t2.* --hiển thị thông tin bảng 1 và bảng 2
FROM table1 AS t1 -- sau khi lấy bảng 1 left join vs bảng 2
LEFT JOIN table2 AS t2 -- bảng sau FROM là bảng gốc
ON t1.key=t2.key; -- thông qua key join

SELECT t1.*,t2.* --hiển thị thông tin bảng 1 và bảng 2
FROM table1 AS t1 -- sau khi lấy bảng 1 right join vs bảng 2
RIGHT JOIN table2 AS t2 -- bảng sau RIGHT JOIN là bảng gốc
ON t1.key=t2.key; -- thông qua key join
