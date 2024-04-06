--ex1
SELECT 
sum (case when device_type = 'laptop' then 1 else 0 end) as laptop_views,
sum (case when device_type in ('tablet', 'phone') then 1 else 0 end ) as mobile_views
FROM viewership;
--ex2
select x,y,z,
case 
    when x+y>z and x+z >y and z+x >y then 'Yes'
    else 'No'
end as triangle
from Triangle
--ex3
SELECT 
ROUND(CAST(SUM(CASE WHEN call_category is NULL OR call_category = 'n/a' 
THEN 1 ELSE 0 END) * 100 / COUNT(*) as DECIMAL),1) as call_percentage 
from callers
--ex4
select name 
from customer
where referee_id <>2 or referee_id is null
--ex5
select 
survived,
SUM (CASE when pclass = 1 then 1 else 0 end ) as first_class,
SUM (CASE when pclass = 2 then 1 else 0 end ) as second_class,
SUM (CASE when pclass = 3 then 1 else 0 end ) as third_class
from titanic
group by survived
