--ex1
select name from city where population>120000 and countrycode = 'USA';
--ex2
select * from city where countrycode = 'JPN';
--ex3
SELECT city, states from station;
--ex4
select distinct city from station 
where city like 'A%' or city like 'E%' or city like 'I%' or city like 'O%' or city like 'U%';
--ex5
select distinct city from station 
where city like '%a' or city like '%e' or city like '%i' or city like '%o' or city like '%u';
-ex6
select distinct city from station 
where (city not like 'A%' and city not like 'E%' and city not like 'I%' and city not like 'O%' and city not like 'U%');
--ex7
select name from employee order by name;
-- ex8
select name from employee where (salary>2000 and months <10) order by employee_id;
-ex9
select product_id from Products
where low_fats ='Y' and recyclable = 'Y';
--ex10

