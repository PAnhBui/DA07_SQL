select * from SALES_DATASET_RFM_PRJ
--1) Chuyển đổi DL phù hợp cho các trường
ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN ordernumber TYPE numeric USING (trim (ordernumber):: numeric);
ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN quantityordered TYPE int USING (trim (quantityordered):: int);
ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN priceeach TYPE numeric USING (trim (priceeach):: numeric);
ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN orderlinenumber TYPE int USING (trim (orderlinenumber):: int);
ALTER TABLE SALES_DATASET_RFM_PRJ 
ALTER COLUMN sales TYPE decimal USING (trim (sales):: decimal);

-- Em chưa đổi đc type của trường date -> bị báo datatype ko đúng
--ALTER TABLE SALES_DATASET_RFM_PRJ 
-- ALTER COLUMN orderdate TYPE timestamp USING (trim (orderdate):: timestamp);

/*2)Check NULL/BLANK ở ORDERNUMBER, QUANTITYORDERED, 
PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE. */ 
SELECT case when SALES IS NULL or SALES = " "
        then 'empty'
        else SALES
   end as SALES from SALES_DATASET_RFM_PRJ
-- -> KO trường nào bị NULL/BLANK
/* 3) Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME . 
Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, 
chữ cái tiếp theo viết thường. 
Gợi ý: ( ADD column sau đó UPDATE)
*/
