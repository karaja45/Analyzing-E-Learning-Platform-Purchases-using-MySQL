create database if not exists elearning_platform_purchases;
use elearning_platform_purchases;

create table if not exists learners(
learner_id int primary key,
full_name varchar(50),
country varchar(60));

create table if not exists courses(
course_id int primary key,
course_name varchar(60),
category varchar(50),
unit_price decimal (10,2));

create table if not exists purchases(
purchase_id int primary key,
learner_id int references learners(learner_id),
course_id int references courses(course_id),
quantity int,
purchase_date date default(current_date()));

insert into learners (learner_id,full_name,country)values
(1,'karthik_raja','india'),
(2,'lalith_mohan','india'),
(3,'ajay_buster','australia'),
(4,'balaji_hari','america'),
(5,'gautham_stuart','germany');

insert into courses(course_id,course_name,category,unit_price)values
(101,'mysql','IT',45000),
(102,'python','IT',50000),
(103,'AutoCAD','MECH',30000),
(104,'biology','biotech',50000),
(105,'MBBS','doctor',60000);

insert into purchases(purchase_id,learner_id,course_id,quantity,purchase_date)values
(11,1,101,1,'2025-08-12'),
(12,1,102,1,'2025-10-21'),
(13,2,103,2,'2025-12-10'),
(14,3,104,2,'2026-01-15'),
(15,3,105,1,'2026-03-23'),
(16,4,101,2,'2025-06-25'),
(17,5,103,3,'2025-04-14'),
(18,5,102,1,'2026-02-18');

select * from purchases;

select l.learner_id,
l.full_name as learner_name,
sum(p.quantity*c.unit_price)as total_revenue
from purchases p
join learners l 
on p.learner_id=l.learner_id
join courses c
on p.course_id=c.course_id
GROUP BY 
    l.learner_id, l.full_name
ORDER BY 
    total_revenue DESC;
    
    SELECT 
    l.learner_id,
    l.full_name        AS learner_name,
    c.course_name,
    c.category,
    p.quantity,
    ROUND(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM purchases p
INNER JOIN learners l 
    ON p.learner_id = l.learner_id
INNER JOIN courses c 
    ON p.course_id = c.course_id
ORDER BY p.purchase_date;

SELECT 
    l.learner_id,
    l.full_name        AS learner_name,
    c.course_name,
    c.category,
    p.quantity,
    ROUND(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM learners l
LEFT JOIN purchases p 
    ON l.learner_id = p.learner_id
LEFT JOIN courses c 
    ON p.course_id = c.course_id
ORDER BY l.learner_id;

SELECT 
    l.learner_id,
    l.full_name        AS learner_name,
    c.course_name,
    c.category,
    p.quantity,
    ROUND(p.quantity * c.unit_price, 2) AS total_amount,
    p.purchase_date
FROM learners l
RIGHT JOIN purchases p 
    ON l.learner_id = p.learner_id
RIGHT JOIN courses c 
    ON p.course_id = c.course_id
ORDER BY p.purchase_date;

SELECT 
    l.learner_id,
    l.full_name AS learner_name,
    l.country,
    ROUND(SUM(p.quantity * c.unit_price), 2) AS total_spent
FROM learners l
JOIN purchases p 
    ON l.learner_id = p.learner_id
JOIN courses c 
    ON p.course_id = c.course_id
GROUP BY 
    l.learner_id, l.full_name, l.country
ORDER BY total_spent DESC;


select 
c.course_id,
c.course_name,
sum(p.quantity) as total_quantity_sold
from courses c
join purchases p 
on c.course_id=p.course_id
group by
c.course_id,c.course_name
order by total_quantity_sold desc
limit 3;

select
c.category,
round(sum(p.quantity*c.unit_price),2) as total_revenue,
count(distinct p.learner_id) as unique_learners
from courses c
join purchases p 
on c.course_id=p.course_id
group by c.category
order by total_revenue desc;


select 
l.learner_id,
l.full_name as learner_name,
count(distinct c.category) as category_count
from learners l
join purchases p 
on l.learner_id = p.learner_id
join courses c 
on p.course_id=c.course_id
group by l.learner_id,l.full_name
having count(distinct c.category)>1;


select
c.course_id,
c.course_name,
c.category
from courses c
join purchases p 
on c.course_id=p.course_id
where p.purchase_id is null;








    
    









