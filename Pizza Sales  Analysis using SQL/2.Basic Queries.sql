-- Basic

-- 1.Determine the overall count of orders made.

# Fetching (orders) table.
SELECT 
    *
FROM
    orders;
# Fetching (orders) table with count of orders made.
SELECT 
    COUNT(order_id)
FROM
    orders;
# Fetching (orders) table with count of orders made with temporary name.
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;
--------------------------------------------------------------------------------------------------------------
-- 2.Compute the total income derived from selling pizzas.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_income
FROM
    order_details
        INNER JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;

--------------------------------------------------------------------------------------------------------------

-- 3.Find out the pizza with the highest price tag.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        INNER JOIN
    pizzas ON pizza_types.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

--------------------------------------------------------------------------------------------------------------

-- 4.Determine the pizza size that is most frequently ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        INNER JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;

-------------------------------------------------------------------------------------------------------------

-- 5. Provide a list of the five most popular pizza varieties, accompanied by their order quantities.

SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5; 

-------------------------------------------------------------------------------------------------------------
