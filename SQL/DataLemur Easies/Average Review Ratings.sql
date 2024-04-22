SELECT      EXTRACT(MONTH FROM submit_date) as mth, 
            product_id, 
            ROUND(AVG(stars), 2) as avg_stars
FROM        reviews

-- We want to group by both the month and the product_id to obtain an average for each product, for each month.
GROUP BY    EXTRACT(MONTH FROM submit_date), 
            product_id
ORDER BY    mth, 
            product_id ASC