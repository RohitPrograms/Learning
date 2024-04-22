-- First, we want some way to rank the records that we have in order to draw comparisons between certain records
WITH rankedTable AS (SELECT     *, 
                                ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY transaction_date ASC ) AS rowNum 
                                -- We want separate orderings for each product, hence the partition.
                    FROM        user_transactions)

-- This select statement gets us the key statistics we are looking for.
SELECT      EXTRACT(YEAR FROM currentRecord.transaction_date) AS year,
            currentRecord.product_id,
            currentRecord.spend AS curr_year_spend,
            previousRecord.spend AS prev_year_spend,
            ROUND(100 * (currentRecord.spend - previousRecord.spend) / previousRecord.spend, 2) AS yoy_rate

-- We want to left join rankedTable to itself so that we have the current year's and previous year's record in one row 
-- We use left to include the first year's record for each product. an INNER JOIN would not include these records
FROM        rankedTable AS currentRecord 
LEFT JOIN   rankedTable AS previousRecord 
ON          (currentRecord.rowNum = previousRecord.rowNum + 1) 
-- This is to make sure we append the PREVIOUS record to the current one.
AND         (currentRecord.product_id = previousRecord.product_id) 
-- Since multiple rows/products can have RowNums of 1 and 2, we want to make sure we LEFT join on the product_ids being equal as well.