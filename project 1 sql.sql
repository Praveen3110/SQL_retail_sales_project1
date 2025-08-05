#SQL Retail Sales Analysis
use project;

#create a table to import dataset
drop table if exists retail_sales;
create table retail_sales(
transactions_id int primary key ,
sale_date date,
sale_time time,
customer_id int,
gender varchar(15),
age int,
category varchar(100),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);

use project;
select * from retail_sales limit 10;


#DATA CLEANING
#count the no.of data available in the dataset
select count(*) from retail_sales;

#check if there is any null value in the dataset
select *
from retail_sales
where transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or 
gender is null or 
age is null or
category is null or 
quantiy is null or 
price_per_unit is null or 
cogs is null or 
total_sale is null;

#id there is any null values then use this command to delete it
delete from retail_sales 
where transactions_id is null or
sale_date is null or
sale_time is null or
customer_id is null or 
gender is null or 
age is null or
category is null or 
quantiy is null or 
price_per_unit is null or 
cogs is null or 
total_sale is null;

#DATA EXPLORATION
#how many sales we have
select count(*)as total_sales from retail_sales;

#how many unique customers we have
select distinct count(customer_id) as total_customers from retail_sales;

#how many category we have
select count(distinct category) as no_of_category from retail_sales ;

#what are are the category present
select distinct category from retail_sales;

#DATA ANALYSIS OR BUSINESS PROBLEMS
#1.write query to retrieve all the columns for sales made on "2022-11-05"
select * from retail_sales 
where sale_date="2022-11-05";

#2.write a query to retrieve all transactions where the category is "clothing" and the quantity id more than 4 in the month of nov-2022
select *
 from retail_sales
where category="clothing" 
and month(sale_date)=11
and year(sale_date)=2022 
and quantiy >=4;

#3.write a sql query to calculate the total_sales for each category
select sum(total_sale) as sum_total_category,count(*) as total_orders ,category
from retail_sales
group by category;

#4.find the average age of the customer who purchased items from the "beauty" category
select round(avg(age),2)
from retail_sales
where category="beauty";

#5.write a SQL query to find all transactions where the total_sales is greater than 1000
select *
from retail_sales
where total_sale>1000;

#6.find the total_no_of transactions made by each gender in each category
select count(transactions_id) as no_of_transaction,gender,category
from retail_sales
group by gender,category
order by category,no_of_transaction,gender;

#7.find the average sale for each month.Find out the best selling month of each year
select * from
(select round(avg(total_Sale),2) as avg_sale,month(sale_date) as month_a,year(sale_date) as year_b,rank()over(partition by year(sale_date) order by avg(total_sale)desc)as rnk
from retail_sales as average
group by year_b,month_a )as t1
where rnk=1;

#8.find the top 5 customers based on the highest total sales
select customer_id,sum(total_sale) as total_sale
from retail_sales
group by customer_id
order by sum(total_sale) desc
limit 5;


#9.find the no of unique customers who purchased items in each category
select category,count(distinct customer_id) as count_of_unique
from retail_Sales
group by category;

#10.write a sql query to create each shift and number of orders (example morning <=12,afternoon between 12 &17,evening >17)
select *,case 
				when hour(sale_time)<12 then 'morning shift'
                when hour(sale_time) between 12 and 17 then 'afternoon shift'
                else 'night shift'
                end as shift_timing
from retail_sales;

#11.count the total no of transaction made on each shift
with cte as(
select *,case 
				when hour(sale_time)<12 then 'morning shift'
                when hour(sale_time) between 12 and 17 then 'afternoon shift'
                else 'night shift'
                end as shift_timing
from retail_sales
)
select count(*) as no_of_transaction,shift_timing
from cte 
group by shift_timing;

#-------end of the project--------