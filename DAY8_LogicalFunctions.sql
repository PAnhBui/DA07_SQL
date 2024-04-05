-- 1) CASE-WHEN
-- cú pháp
SELECT 
CASE
 WHEN codition1 THEN result1
 WHEN codition2 THEN result2
 ..
 ELSE resultn
FROM table_nm
/* EXAMPLE: Hãy phân loại các bộ phim theo thời lượng short-medium-long cụ thể:
- short : <60 phút
- medium: 60 -120 phút
- long: > 120 phuts 
=> CASE 
        WHEN... THEN
    END ;*/
select film_id,
CASE
    WHEN length <60 THEN 'short'
	WHEN length BETWEEN 60 AND 120 THEN 'medium'
	WHEN length > 120 THEN 'long' -- ELSE 'long'
END category
FROM film
-- với mỗi category có bn phim
select
CASE
    WHEN length <60 THEN 'short'
	WHEN length BETWEEN 60 AND 120 THEN 'medium'
	ELSE 'long'
END category,
COUNT (*) AS so_luong
FROM film
GROUP BY category
/* bộ phim có tag là 1 nếu rating là G hoặc PG
tag là 0 trong các TH còn lại */
Select film_id,
CASE 
    WHEN rating IN ('PG','G') THEN 1
	ELSE 0
END TAG
from film
-- challenge 1
/*Bạn cần tìm hiểu xem công ty đã bán bao nhiêu vé trong các danh mục sau
•  Low price ticket: total_amount < 20,000
•  Mid price ticket: total_amount between 20,000 and 150,000
•  High price ticket: total_amount >= 150,000*/

SELECT 
CASE
 WHEN amount <20000 THEN 'Low price ticket'
 WHEN amount BETWEEN 20000 AND 150000 THEN 'Mid price ticket'
 ELSE 'High price ticket'
END AS category,
COUNT(*) AS SO_LUONG
FROM bookings.ticket_flights
GROUP BY category
-- challenge 2
/*Bạn cần biết có bao nhiêu chuyến bay đã khởi hành vào các mùa sau:

Mùa xuân: Tháng 2,3,4
Mùa hè: Tháng 5,6,7
Mùa thu: Tháng 8,9,10
Mùa đông: 11,12,1
*/
SELECT 

CASE
   WHEN EXTRACT(MONTH FROM scheduled_departure) IN (2,3,4) THEN 'Mùa xuân'
   WHEN EXTRACT(MONTH FROM scheduled_departure) IN (5,6,7) THEN 'Mùa hè'
   WHEN EXTRACT(MONTH FROM scheduled_departure) IN (8,9,10) THEN 'Mùa thu'
   ELSE 'Mùa Đông'
END AS season,
count(*)
FROM bookings.flights
GROUP BY season
--challenge 3
/*Bạn muốn tạo danh sách phim phân cấp độ theo cách sau:
1. Xếp hạng là 'PG' hoặc 'PG-13' hoặc thời lượng hơn 210 phút: 'Great rating or long (tier 1)
2. Mô tả chứa 'Drama' và thời lượng hơn 90 phút: 
Long drama (tier 2)'
3. Mô tả có chứa 'Drama' và thời lượng không quá 90 phút: 
'Shcity drama (tier 3)
4. Giá thuê thấp hơn $1: 'Very cheap (tier 4)'

Nếu một bộ phim có thể thuộc nhiều danh mục, nó sẽ được chỉ định ở cấp cao hơn. Làm cách nào để bạn có thể chỉ lọc những phim xuất hiện ở một trong 4 cấp độ này?
*/
SELECT 
film_id,
CASE
  WHEN rating IN ('PG','PG-13') or length >210 THEN 'Great rating or long (tier 1)'
  WHEN description LIKE '%Drama%' AND length >90 THEN 'Long drama (tier 2)'
  WHEN description LIKE '%Drama%' AND length <=90 THEN 'Shcity drama (tier 3)'
  WHEN rental_rate <1 THEN 'Very cheap (tier 4)'
END AS category

FROM film
WHERE CASE
  WHEN rating IN ('PG','PG-13') or length >210 THEN 'Great rating or long (tier 1)'
  WHEN description LIKE '%Drama%' AND length >90 THEN 'Long drama (tier 2)'
  WHEN description LIKE '%Drama%' AND length <=90 THEN 'Shcity drama (tier 3)'
  WHEN rental_rate <1 THEN 'Very cheap (tier 4)'
END IS NOT NULL

