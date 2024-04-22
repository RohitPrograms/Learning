SELECT      ROUND((SUM(item_count * order_occurrences) / SUM(order_occurrences)) :: numeric, 1) as mean 
            -- I use the :: numeric feature just in case the weighted average is parsed as an INT
FROM        items_per_order