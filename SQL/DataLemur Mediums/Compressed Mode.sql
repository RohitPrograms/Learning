-- First, I am using a CTE to rank the item_counts by the number of times it occurs (order_occurrences)
WITH item_ranking AS    (SELECT     item_count,
                                    RANK() OVER(ORDER BY order_occurrences DESC) as item_rank -- I use the window function RANK() rather than ROW_NUMBER() since multiple item_counts could have the same number of occurrences
                                                                                                -- Using RANK() allows for multiple rows to have value 1.
                        FROM        items_per_order)

SELECT      item_count AS mode
FROM        item_ranking
WHERE       item_rank = 1 -- Rows with an item_rank of 1 mean that those item_counts occurred the most. Therefore, those item_counts are the mode.