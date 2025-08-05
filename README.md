
# 🛒 Retail Sales SQL Analysis Project

This project involves cleaning, exploring, and analyzing a retail sales dataset using SQL. The purpose is to gain insights into customer behavior, sales trends, and category performance.

---

## 📁 Dataset Structure

The dataset is stored in a table named `retail_sales` with the following columns:

| Column           | Description                          |
|------------------|--------------------------------------|
| transactions_id  | Unique transaction ID (Primary Key)  |
| sale_date        | Date of the sale                     |
| sale_time        | Time of the sale                     |
| customer_id      | Unique customer ID                   |
| gender           | Customer gender                      |
| age              | Customer age                         |
| category         | Product category                     |
| quantiy          | Number of items purchased            |
| price_per_unit   | Price per item                       |
| cogs             | Cost of goods sold                   |
| total_sale       | Total amount for the transaction     |

---

## 🧹 Data Cleaning

### 1. Count total records
```sql
SELECT COUNT(*) FROM retail_sales;
```
➡️ Counts the total number of rows in the table.

### 2. Check for NULL values
```sql
SELECT * FROM retail_sales
WHERE transactions_id IS NULL OR ...;
```
➡️ Identifies any incomplete records with missing data.

### 3. Delete NULL records
```sql
DELETE FROM retail_sales 
WHERE transactions_id IS NULL OR ...;
```
➡️ Cleans the dataset by removing rows with NULLs.

---

## 📊 Data Exploration

### 1. Total number of sales
```sql
SELECT COUNT(*) AS total_sales FROM retail_sales;
```
➡️ Returns the total number of sales transactions.

### 2. Total number of unique customers
```sql
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM retail_sales;
```
➡️ Shows how many unique customers made purchases.

### 3. Number of categories
```sql
SELECT COUNT(DISTINCT category) AS no_of_category FROM retail_sales;
```
➡️ Gives the total number of unique product categories.

### 4. List all categories
```sql
SELECT DISTINCT category FROM retail_sales;
```
➡️ Lists all the different product categories.

---

## 🔍 Business Problem Analysis

### 1. Sales on a specific date
```sql
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';
```
➡️ Retrieves all transactions made on November 5, 2022.

### 2. Clothing sales with quantity > 4 in Nov 2022
```sql
SELECT * FROM retail_sales
WHERE category = 'clothing' AND MONTH(sale_date) = 11 AND YEAR(sale_date) = 2022 AND quantiy >= 4;
```
➡️ Filters clothing transactions in Nov 2022 where quantity was 4 or more.

### 3. Total sales per category
```sql
SELECT SUM(total_sale) AS sum_total_category, COUNT(*) AS total_orders, category
FROM retail_sales GROUP BY category;
```
➡️ Calculates the total revenue and number of orders for each category.

### 4. Average age of beauty buyers
```sql
SELECT ROUND(AVG(age), 2) FROM retail_sales WHERE category = 'beauty';
```
➡️ Returns the average age of customers who bought beauty products.

### 5. Transactions with high sales
```sql
SELECT * FROM retail_sales WHERE total_sale > 1000;
```
➡️ Finds transactions where the sale value exceeded 1000.

### 6. Transactions by gender and category
```sql
SELECT COUNT(transactions_id) AS no_of_transaction, gender, category
FROM retail_sales GROUP BY gender, category
ORDER BY category, no_of_transaction, gender;
```
➡️ Counts how many sales each gender made in every category.

### 7. Best-selling month of each year
```sql
SELECT * FROM (
    SELECT ROUND(AVG(total_Sale), 2) AS avg_sale, MONTH(sale_date) AS month_a,
           YEAR(sale_date) AS year_b, RANK() OVER(PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
    FROM retail_sales GROUP BY year_b, month_a
) AS t1 WHERE rnk = 1;
```
➡️ Finds the month with the highest average sales in each year.

### 8. Top 5 customers by total sales
```sql
SELECT customer_id, SUM(total_sale) AS total_sale
FROM retail_sales GROUP BY customer_id
ORDER BY total_sale DESC LIMIT 5;
```
➡️ Lists the top 5 customers based on total spending.

### 9. Unique customers per category
```sql
SELECT category, COUNT(DISTINCT customer_id) AS count_of_unique
FROM retail_sales GROUP BY category;
```
➡️ Counts how many different customers bought from each category.

### 10. Add shift timing to each transaction
```sql
SELECT *, CASE 
             WHEN HOUR(sale_time) < 12 THEN 'morning shift'
             WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon shift'
             ELSE 'night shift'
         END AS shift_timing
FROM retail_sales;
```
➡️ Categorizes each sale into a shift (morning, afternoon, or night).

### 11. Count transactions per shift
```sql
WITH cte AS (
    SELECT *, CASE 
                 WHEN HOUR(sale_time) < 12 THEN 'morning shift'
                 WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon shift'
                 ELSE 'night shift'
             END AS shift_timing
    FROM retail_sales
)
SELECT COUNT(*) AS no_of_transaction, shift_timing FROM cte GROUP BY shift_timing;
```
➡️ Aggregates total transactions made during each shift.

---

## ✅ Project Conclusion

This project uses SQL to derive useful business insights from retail transaction data, helping understand customer behavior, sales performance, and time-based trends.

---

## 🧠 Tools Used
- MySQL
- SQL Workbench
- GitHub

---

## 👨‍💻 Author

**Praveen S R**  
Final Year Mechanical Engineering Student  
SQL | Data Analytics | Machine Learning  
