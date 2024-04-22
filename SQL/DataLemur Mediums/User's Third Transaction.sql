--  Associate each transaction to a transaction_num

    -- We use the window function ROW_NUMBER() to assign a unique sequential integer (1,2,3...) to each row in a result set based on a specified ordering
        -- We pair this with (ORDER BY transaction_date ASC) to define the specific ordering of our set. This way, 1 denotes the earliest transaction.
        -- If we did (ORDER BY transaction_date DESC), 1 would denote the most recent transaction.

    -- We also include (PARTITION BY user_id) to divide/partition our result set into independent groups based on user_id.
        -- This way, our window function is performed separately within each partition. 
        -- In this example, each user_id will have it's own (1,2,3...) sequence.
WITH transaction_numbers AS    (SELECT     *,
                                            ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date ASC) as transaction_num 
                                FROM        transactions)

-- Now, we just select the transactions with a transaction_num = 3, since that signifies the user's third transaction (if they have one).
SELECT      user_id, 
            spend, 
            transaction_date 
FROM        transaction_numbers
WHERE       transaction_num = 3
