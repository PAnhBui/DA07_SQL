--DDL: CREATE -DROP-ALTER
CREATE TABLE manager
(
    manager_id INT PRIMARY KEY,
	user_name VARCHAR (20) UNIQUE,
	first_name VARCHAR (50),
	last_name VARCHAR (50) DEFAULT 'No info',
	date_of_birth DATE,
	address_id INT
)
--truy vấn DL lấy ra dsach KH và địa chỉ tương ứng
-- sau đó lưu thông tin đó vào bảng đặt tên là customer_info
(customer_id,full_name,email,address)
CREATE TABLE customer_info AS (
SELECT 
customer_id, first_name||last_name AS full_name,
email,
b.address
FROM customer AS a
JOIN address AS b ON a.address_id=b.address_id);

SELECT * FROM customer_info

-- CREATE TEMPORARY TABLE
--CREATE VIEW
/*challenge: Tạo view có tên movies_category hiển thị danh sách film 
gồm title,length,category name đc sx giảm dần theo length
- Lọc KQ nh phim trong danh mục Action và Comedy*/
CREATE OR REPLACE VIEW movies_category AS (
SELECT 
a.title, a.length,
c.name as category_name
FROM film AS a
JOIN public.film_category AS b ON a.film_id=b.film_id
JOIN public.category AS c ON c.category_id=b.category_id
ORDER BY a.length DESC
)

SELECT * FROM movies_category
WHERE category_name IN ('Action','Comedy')


--ALTER TABLE
