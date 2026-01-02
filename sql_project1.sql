-- Sql Sales Reatil Analysis
create database sql_project_p1;

create table retail_sales (
		transactions_id	int primary key,
		sale_date date,	
		sale_time time,	
		customer_id int,
		gender	varchar(15),
		age	int,
        category varchar(25),
		quantiy	int,
		price_per_unit	float,
		cogs float,	
		total_sale float
);
 
select count(*) from retail_sales;

-- checking null values

select * from retail_sales; 

select * from retail_sales 
where transactions_id is null 
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null 
or total_sale is null;
-- data cleaning
delete from retail_sales 
where transactions_id is null 
or sale_date is null
or sale_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantiy is null
or price_per_unit is null
or cogs is null 
or total_sale is null;

-- data exploration
-- how many sales we have?
select count(*) as total_sale from retail_sales;
 
 -- how many customers we have?
select count(distinct customer_id) as total_sale from retail_sales;
 
-- how many dsitinct categories
select distinct category from retail_sales;

-- Data analysis & Business Key Problems and Answers

-- Q1 Write a sql Query to retrive all columns for sale made on '2022-11-05'
select * from retail_sales where sale_date='2022-11-05';

-- Q2 Write a Sql query to retrive all transaction where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov -2022
select 
 * from retail_sales where category ='Clothing' and sale_date between '2022-11-01' and '2022-11-30' 
 and quantiy >= 4;
 
 -- Q3 Write a Sql query to to calculate the total sales (total_sale) for each Category
 select category, sum(total_sale) as net_sale,
count(*) as total_orders
from
 retail_sales 
 group by category; 

-- Q4 Write a Sql query to find the average age of customers who purchased items from the 'Beauty' Category 
select  round(avg(age),2)as average_age
from
retail_sales where Category ='Beauty';

-- Q5 Write a Sql Query to find all transaction where the total_sale is greater than 1000
select * from retail_sales where total_sale>1000;

-- Q6 Write a Sql Query to find the total number of transactions(transaction_id) made by each gender in each category
select category, gender,count(*) as total_trans from retail_sales
group by category, gender


