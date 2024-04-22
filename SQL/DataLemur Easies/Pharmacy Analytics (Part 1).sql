SELECT      drug, 
            (total_sales - cogs) AS total_profit
FROM        pharmacy_sales
ORDER BY    total_profit DESC
LIMIT       3 -- We only want the top 3 companies in terms of profits.