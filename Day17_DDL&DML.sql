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
