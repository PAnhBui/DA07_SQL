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
select name from customer 
where referee_id <> 2 or referee_id is NULL;
--ex11
select name, population, area from world
where area >=3000000 or population >= 25000000;
--ex12
select distinct author_id as id from views
where author_id = viewer_id
order by id;
--ex13
SELECT * FROM parts_assembly
WHERE finish_date is NULL;
-- ex14
select * from lyft_drivers
where yearly_salary <=30000 or yearly_salary>=70000;
--ex15
select * from uber_advertising
where year =2019 and money_spent >100000;
