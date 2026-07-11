
--1. Total Revenue: The sum of the total price of all pizza orders

SELECT SUM(total_price) AS "Total Revenue" FROM pizza_sales;

--2. Average Order Value: The average amount spent per order, calcualted by dividing the total revenue by the total number of orders

SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS "Average Order Value" FROM pizza_sales

--3. Total Pizzas Sold: The sum of the quantities of all pizzas sold

SELECT SUM(quantity) AS "Total Pizzas Sold" FROM pizza_sales

--4. Total Orders: The total number of orders placed

SELECT COUNT(DISTINCT order_id) AS "Total Orders" FROM pizza_sales 

--5. Average Pizzas Per Order: The average number of pizzas sold per order, calculated by dividing the total number of pizzas sold by the total number of orders

SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / 
CAST(COUNT(DISTINCT order_id) AS DECIMAL (10,2)) AS DECIMAL (10,2)) AS "Average Pizzas Per Order" FROM pizza_sales;

--Chart Requirements

--We would like to visaulize various aspects of our pizza sales data to gain insights and understand key trends. We have determined the following requirmeents 
--for creating charts:

--1. Daily Trend for Total Orders: Create a bar chart that displays the daily trend of total orders over a specific time period. 
--This chart will help us identify any patterns or fluctuations in order volumes on a daily basis.

SELECT DATENAME(DW, order_date) as "Order Day", COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizza_sales
GROUP BY DATENAME(DW, order_date)

--2.Hourly Trend for Total Orders:
--Create a line chart that illustrates the hourly trend of total orders throughout the day. 
--This chart will allow us to identify peak hours or periods of high order activity.

SELECT DATEPART(HOUR, order_time) AS "Order Hours", COUNT(DISTINCT order_id) AS "Total Orders"
FROM pizza_sales
GROUP BY DATEPART(HOUR, order_time)
ORDER BY DATEPART(HOUR, order_time)

--3.Percentage of Sales by Pizza Category:
--Create a pie chart that shows the distribution of sales across different pizza categories. 
--This chart will provide insights into the popularity of various pizza categories and their contribution to overall sales.

SELECT pizza_category, CAST(SUM (total_price) AS DECIMAL (10,2)) AS "Total Sales", 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS "Percentage of Total Sales"
FROM pizza_sales 
GROUP BY pizza_category

--4.Percentage of Sales by Pizza Size:
--Generate a pie chart that represents the percentage of sales attributed to different pizza sizes. 
--This chart will help us understand customer preferences for pizza sizes and their impact on sales.

SELECT pizza_size, CAST(SUM (total_price) AS DECIMAL (10,2)) AS "Total Sales", 
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL (10,2)) AS "Percentage of Total Sales"
FROM pizza_sales 
GROUP BY pizza_size 
ORDER BY "Percentage of Total Sales" DESC

--5.Total Pizzas Sold by Pizza Category:
--Create a funnel chart that presents the total number of pizzas sold for each pizza category. 
--This chart will allow us to compare the sales performance of different pizza categories.

SELECT pizza_category, SUM(quantity) AS "Total Pizzas Sold" 
FROM pizza_sales
GROUP BY pizza_category


--6.Top 5 Best Sellers by Total Pizzas Sold:
--Create a bar chart highlighting the top 5 best-selling pizzas based on the total number of pizzas sold. 
--This chart will help us identify the most popular pizza options.

SELECT TOP 5 pizza_name, sum(quantity) AS "Total Pizzas Sold" 
FROM pizza_sales 
GROUP BY pizza_name 
ORDER BY "Total Pizzas Sold" DESC

--7. Bottom 5 Worst Sellers by Total Pizzas Sold:
--Create a bar chart showcasing the bottom 5 worst-selling pizzas based on the total number of pizzas sold. 
--This chart will enable us to identify underperforming or less popular pizza options.

SELECT TOP 5 pizza_name, SUM(quantity) AS "Total Pizzas Sold" 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY "Total pizzas Sold" ASC




