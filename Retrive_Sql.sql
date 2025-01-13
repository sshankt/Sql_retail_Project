Create database sql_project_p2;
drop table if exists retail_sales;
create table retail_sales
  (
transactions_id Int primary key,	
sale_date	date,
sale_time	Time,
customer_id	int,
gender	varchar(15),
age	    Int,
category	varchar(15),
quantiy	   Int,
price_per_unit	float,
cogs	float,
total_sale  float
	);

SELECT 
    *
FROM
    retail_sales
LIMIT 10;

select count(*) from retail_sales;

-- Data cleaning
SELECT 
    *
FROM
    retail_sales
WHERE
    transactions_id IS NULL;
  

select * from retail_sales
where sale_date is null;



select * from retail_sales
where 
   transactions_id is null
   or 
   sale_date is null
   or
   sale_time is null
   or 
   customer_id is null
   or
   gender is null
   or
   age is null
   or 
   category is null
   or
   quantiy is null
   or
   price_per_unit is null
   or 
   cogs is null
   or
   total_sale is null;
   
   -- Data Exploration
  SELECT 
    *
FROM
    retail_sales;
   -- How many sales we have 
   SELECT 
    COUNT(*) AS total_sale
FROM
    retail_sales;
   
   -- How many customers we have ?
   
  SELECT 
    COUNT(DISTINCT customer_id) AS total_sale
FROM
    retail_sales;
   
 SELECT DISTINCT
    category
FROM
    retail_sales;
   
   -- Data Analyst & Business Questions Answers
   
   -- Write a SQL query to retrieve all columns for sales made on '2022-11-05
   
  SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
   
-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity 
-- sold is more than 10 in the month of Nov-2022

SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'clothing'
        AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
        AND quantiy >= 4
GROUP BY 1;

-- Write a SQL query to calculate the total sales (total_sale) for each category
SELECT 
    category, SUM(total_sale) AS Sale, COUNT(*) AS total_orders
FROM
    retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT 
    ROUND(AVG(age), 2)
FROM
    retail_sales
WHERE
    category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000

SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

SELECT 
    category, COUNT(transactions_id), gender
FROM
    retail_sales
GROUP BY category , gender
ORDER BY 1;

--  Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select * from
(
     select year(sale_date) as Year,
month(sale_date) as Month , ROUND(avg(total_sale),2) as Avg_sale,
rank() over(partition by year(sale_date) order by Avg(total_sale) desc) as Top_sale
from retail_sales
group by 1,2
) as T1 
where Top_sale = 1;

-- Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT 
    customer_id, SUM(total_sale) AS Total_sale
FROM
    retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT 
    category, COUNT(DISTINCT customer_id)
FROM
    retail_sales
GROUP BY category;
 

-- Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(sale_time) AS number_of_sale
FROM
    retail_sales
GROUP BY shift
ORDER BY shift;

-- End Project
