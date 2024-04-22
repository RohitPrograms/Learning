SELECT      manufacturer, 
            COUNT(drug), 
            SUM(cogs - total_sales) AS total_loss -- Since we are doing cogs - total_sales when cogs > total_sales,
                                                    -- total_loss will always be a postive number
FROM        pharmacy_sales
WHERE       cogs > total_sales -- We only care about counting the drugs that are associated with losses
GROUP BY    manufacturer
ORDER BY    total_loss DESC