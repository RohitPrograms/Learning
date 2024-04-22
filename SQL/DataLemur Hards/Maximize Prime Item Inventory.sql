-- Original Table:
-- item_id	item_type	    item_category	    square_footage
-- 1374	    prime_eligible	mini refrigerator	68.00
-- 4245	    not_prime	    standing lamp	    26.40
-- 5743	    prime_eligible	washing machine	    325.00
-- 8543	    not_prime	    dining chair	    64.50
-- 2556	    not_prime	    vase	            15.00
-- 2452	    prime_eligible	television	        85.00
-- 3255	    not_prime	    side table	        22.60
-- 1672	    prime_eligible	laptop	            8.50
-- 4256	    prime_eligible	wall rack	        55.50
-- 6325	    prime_eligible	desktop computer	13.20


-- Info needed:
    -- Since we know that there must be the same number of items whether eligible/not, we create the both_info table to record the following...
        -- items per batch. If we caluclate the number of batches within 500,000 sqft, we indirectly calculate the number of items 
            -- since each batch contains exactly 1 of each item.  
        -- total sqft per batch. Same logic as keeping track of items per batch.

WITH both_info AS (SELECT       item_type, 
                                COUNT(item_type) as items_per_batch, 
                                SUM(square_footage) AS sqft_per_batch
                    FROM        inventory
                    GROUP BY    item_type
                ),

-- both_info table
-- item_type	    count_per_batch	    sqft_per_batch
-- not_prime	    4	  (a)           128.50    (c)
-- prime_eligible	6	  (b)           555.20    (d)

-- I just denoted sections a,b,c,d to make my explanation a little more smooth-sailing...

    -- To maximize the total number of prime items, we can simply maximize the number of prime batches,
        -- since each batch requires 1 of every prime item.
    -- Therefore, the maximum number of prime items we can fit is FLOOR(500,000 / sqft_per_batch (d)) * count_per_batch (b)

    -- To calculate the number we not-prime items we can fit, we first need to subtract the space taken from the prime items.
        -- This will always be 500,000 MOD sqft_per_batch (d) since we are trying to initially fit AS MANY prime batches as possible.
        -- If we can't fit another prime batch, we cannot fit anymore prime items since that would result in unequal quantities of prime items.
        -- Therefore, the space that is left over will be the remainder of 500,000 / sqft_per_batch (d) = 500,000 MOD sqft_per_batch (d)

        -- After that, the max number of non-prime items we can fit into the remaining space is...
            -- FLOOR([500,000 mod sqft_per_batch (d)] / sqft_per_batch (c) ) * count_per_batch (a)

    -- Now that we know the formula required to calculate the number of prime and non-prime items, we still have a problem...
        -- Calculating the number of non-prime items is a formula that is dependent on values from the 'prime_eligible' row.
        -- To fix this issue, we can figure out a way to attach the 'prime_eligible' row to the 'not_prime' row

-- there are many ways to do this (e.g a pivot to turn this 2 X 2 table to a 1 x 4), but I've outlined how I did it below with a CTE

append_eligible AS (SELECT      both_info.*, 
                                just_prime.sqft_per_batch AS sqft_per_eligible_batch
                    FROM        both_info CROSS JOIN    (SELECT     * 
                                                        FROM        both_info 
                                                        WHERE       item_type = 'prime_eligible'
                                                        ) AS just_prime
                    )

-- append_eligible table
-- item_type	    count_per_batch	sqft_per_batch	sqft_per_eligible_batch
-- not_prime	    4	            128.50	        555.20
-- prime_eligible	6	            555.20	        555.20

-- within this table, we have all the necessary information to calculate the number of prime and non-prime batches.


SELECT      item_type,
            CASE WHEN item_type = 'prime_eligible' THEN FLOOR(500000 / sqft_per_batch) * items_per_batch 
            ELSE FLOOR(MOD(500000, sqft_per_eligible_batch) / sqft_per_batch) * items_per_batch END AS item_count
FROM        append_eligible
ORDER BY    item_type DESC
