# Pizza-Sales-Analysis-using-SQL


PIZZA SALES ANALYSIS USING SQL

Basic Questions :

1.Determine the overall count of orders made.

Query: SELECT COUNT(order_id) FROM orders;

Description: This query fetches the total count of orders made by counting the number of rows in the orders table.

Output: The total count of orders made.

2.Compute the total income derived from selling pizzas.

Query: SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_income FROM order_details INNER JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id;

Description: This query calculates the total income by summing up the product of the quantity of each pizza and its price, and then rounding the result to two decimal places.

Output: The total income derived from selling pizzas.

3.Find out the pizza with the highest price tag.

Query: SELECT pizza_types.name, pizzas.price FROM pizza_types INNER JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id ORDER BY pizzas.price DESC LIMIT 1;

Description: This query fetches the name and price of the pizza with the highest price tag by joining the pizza_types and pizzas tables and ordering the results by price in descending order.

Output: The name and price of the pizza with the highest price tag.

4.Determine the pizza size that is most frequently ordered.

Query: SELECT pizzas.size, COUNT(order_details.order_details_id) AS order_count FROM pizzas INNER JOIN order_details ON pizzas.pizza_id = order_details.pizza_id GROUP BY pizzas.size ORDER BY order_count DESC;

Description: This query determines the pizza size that is most frequently ordered by counting the number of orders for each pizza size and ordering the results in descending order.

Output: The pizza size that is most frequently ordered along with its order count.

5.Provide a list of the five most popular pizza varieties, accompanied by their order quantities.

Query: SELECT pizza_types.name, SUM(order_details.quantity) AS quantity FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.name ORDER BY quantity DESC LIMIT 5;

Description: This query fetches the names of the five most popular pizza varieties and their order quantities by joining the pizza_types, pizzas, and order_details tables and grouping the results by pizza variety.

Output: The names of the five most popular pizza varieties along with their order quantities.

Intermediate Questions:

1,Combine the required tables in order to ascertain the total quantity of each pizza category that has been ordered.

Query: SELECT pizza_types.category, SUM(order_details.quantity) AS quantity FROM pizza_types JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.category ORDER BY quantity DESC;

Description: This query combines the pizza_types, pizzas, and order_details tables to determine the total quantity of each pizza category that has been ordered.

Output: The total quantity of each pizza category ordered.

2.Analyze the distribution of orders based on the hour of the day.

Query: SELECT HOUR(order_time), COUNT(order_id) AS order_count FROM orders GROUP BY HOUR(order_time);

Description: This query analyzes the distribution of orders based on the hour of the day by grouping the orders table by the hour of the order_time.

Output: The distribution of orders by hour of the day.

3.Merge the appropriate tables to determine how pizzas are distributed across different categories.

Query: SELECT category, COUNT(name) FROM pizza_types GROUP BY category;

Description: This query merges the pizza_types table to determine how pizzas are distributed across different categories by grouping the results by category.

Output: The distribution of pizzas across different categories.

4.Organize the orders by date and compute the average daily number of pizzas that are ordered.

Query: SELECT ROUND(AVG(quantity)) as avg_pizza_ordered_per_day FROM (SELECT orders.order_date, SUM(order_details.quantity) AS quantity FROM orders JOIN order_details ON orders.order_id = order_details.order_id GROUP BY orders.order_date) AS order_quantity;

Description: This query organizes the orders by date and computes the average daily number of pizzas that are ordered by grouping the orders and order_details tables by order_date and calculating the average quantity.

Output: The average daily number of pizzas ordered.

5.Identify the top three pizza types that have been ordered the most, based on revenue.

Query: SELECT pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.name ORDER BY revenue DESC LIMIT 3;

Description: This query identifies the top three pizza types that have been ordered the most, based on revenue, by joining the pizza_types, pizzas, and order_details tables and grouping the results by pizza_types.name.

Output: The top three pizza types ordered based on revenue.

Advance Questions:

1.Determine the proportionate revenue generated by each type of pizza.

Query: SELECT pizza_types.category, ROUND(SUM(order_details.quantity * pizzas.price) / (SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total_income FROM order_details INNER JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id) * 100, 2) AS revenue FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.category ORDER BY revenue DESC;

Description: This query determines the proportionate revenue generated by each type of pizza by calculating the total revenue for each category and then dividing it by the total revenue across all categories.

Output: The proportionate revenue generated by each type of pizza.

2.Evaluate the total revenue accumulated over a period of time.

Query: SELECT order_date, sum(revenue) over (ORDER BY order_date) AS cum_revenue FROM (SELECT orders.order_date, SUM(order_details.quantity * pizzas.price) AS revenue FROM order_details JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id JOIN orders ON orders.order_id = order_details.order_id GROUP BY orders.order_date) AS sales;

Description: This query evaluates the total revenue accumulated over a period of time by using a window function to calculate the cumulative sum of revenue for each order date.

Output: The cumulative revenue for each order date.

3.Identify the three pizza types with the highest revenue in each pizza category.

Query: SELECT name, revenue FROM (SELECT category, name, revenue, RANK() OVER (PARTITION BY category ORDER BY revenue DESC) AS rn FROM (SELECT pizza_types.category, pizza_types.name, SUM(order_details.quantity * pizzas.price) AS revenue FROM pizza_types JOIN pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id JOIN order_details ON order_details.pizza_id = pizzas.pizza_id GROUP BY pizza_types.category, pizza_types.name) AS a) AS b WHERE rn <= 3;

Description: This query identifies the three pizza types with the highest revenue in each pizza category by using a window function to rank the pizza types within each category by revenue.

Output: The three pizza types with the highest revenue in each pizza category.
