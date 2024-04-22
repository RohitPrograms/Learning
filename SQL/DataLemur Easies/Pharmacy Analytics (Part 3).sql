SELECT      manufacturer, 
            CONCAT('$', ROUND(sale / 1000000, 0) :: varchar, ' million') AS sale -- We use :: varchar to cast a integer to a string type
FROM        (SELECT         manufacturer,   -- Here, we utilize a subquery to get the total sales per manufacturer (unrounded)
                            SUM(total_sales) AS sale 
            FROM            pharmacy_sales
            GROUP BY        manufacturer
            ORDER BY        sale DESC) AS temp_table    