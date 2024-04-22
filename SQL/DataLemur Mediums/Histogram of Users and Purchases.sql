-- First, we want the number of products each user bought on each day.
-- This can be achieved by Grouping by transaction_date and user_id.
WITH purchase_counts AS (SELECT     transaction_date, 
                                    user_id,
                                    COUNT(*) AS purchase_count
                        FROM        user_transactions
                        GROUP BY    transaction_date, user_id),

-- Next, we want each users most recent transaction date
most_recent_dates AS    (SELECT     user_id, 
                                    MAX(transaction_date) AS transaction_date
                        FROM        user_transactions
                        GROUP BY    user_id)

-- Finally, we can perform an INNER JOIN on these 2 CTEs.
-- The INNER JOIN will be on the user_ids and transaction_dates
-- This INNER JOIN will return each users most recent transaction_date, along with the number of products they bought on THAT transaction_date
SELECT      purchase_counts.*
FROM        purchase_counts 
INNER JOIN  most_recent_dates
ON          purchase_counts.user_id = most_recent_dates.user_id
AND         purchase_counts.transaction_date = most_recent_dates.transaction_date
ORDER BY    transaction_date, user_id ASC
