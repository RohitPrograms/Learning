-- First, we want a way to get the distinct numer of product categories
WITH num_distinct AS    (SELECT     COUNT(DISTINCT product_category) AS num_distinct_products 
                        FROM        products),

-- Second, we want to figure out how many distinct product categories each customer bought from
info AS (SELECT     customer_id, 
                    COUNT(DISTINCT product_category) as customer_distinct_products
        FROM        customer_contracts 
        INNER JOIN  products
        ON          customer_contracts.product_id = products.product_id
        GROUP BY    customer_id)

-- Finally, we only want to retrieve the customers who bought from all distinct product categories
-- If customer_distinct_products = num_distinct_products, it means that a customer bought from every single product category
SELECT      customer_id 
FROM        info 
CROSS JOIN  num_distinct
-- A CROSS JOIN combines each row from the first table to each row from the second table.
-- Since num_distinct only has 1 cell, this CROSS JOIN essentially adds num_distinct_products to each row
-- From there, we can just check where customer_distinct_products = num_distinct_products.
WHERE       customer_distinct_products = num_distinct_products