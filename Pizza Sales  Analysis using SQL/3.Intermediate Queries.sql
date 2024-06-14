-- Intermediate Level:

-- 1. Combine the required tables in order to ascertain the total quantity of each pizza category that has been ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;

-------------------------------------------------------------------------------------------------------------


-- 2. Analyze the distribution of orders based on the hour of the day.

SELECT 
    HOUR(order_time), COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);

-------------------------------------------------------------------------------------------------------------

-- 3. Merge the appropriate tables to determine how pizzas are distributed across different categories.

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-------------------------------------------------------------------------------------------------------------

-- 4. Organize the orders by date and compute the average daily number of pizzas that are ordered.

SELECT 
    ROUND(AVG(quantity)) as avg_pizza_ordered_per_day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;

-------------------------------------------------------------------------------------------------------------

-- 5. Identify the top three pizza types that have been ordered the most, based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;

----------------------------------------------------------------------------------------------------------------------