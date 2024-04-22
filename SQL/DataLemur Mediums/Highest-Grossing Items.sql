-- First, I am getting the total spend for each product from transactions in 2022.
WITH total_spend_info AS  (SELECT   category, 
                                    product, 
                                    SUM(spend) AS total_spend
                          FROM      product_spend
                          WHERE     EXTRACT(YEAR FROM transaction_date) = 2022
                          -- I could have probably just group by product here, but I grouped by category and product
                          -- in case multiple products have the same name, but they are in different categories.
                          GROUP BY  category, product),

-- Next, I am going to rank the products within each category by the total_spend
Ranking_info AS (SELECT   *,
                          ROW_NUMBER() OVER (PARTITION BY category ORDER BY total_spend DESC) as ranking
                          -- In the case that two products within a category have the same total spend, I'd want to return both rows.
                          -- This is why I utilized ROW_NUMBER() rather than RANK() of DENSE_RANK()
                FROM      total_spend_info)

-- Finally, I can just select the rows with a ranking <= 2 to get the top 2 products for each category.
SELECT    category, 
          product, 
          total_spend
FROM      Ranking_info
WHERE     ranking <= 2