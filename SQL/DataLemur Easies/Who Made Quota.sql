-- First, we want a way to determine the total deal amount each employee got.
-- This sum will be used to see if an employee reached their quota or not.
WITH total_deals AS (SELECT     employee_id, 
                                SUM(deal_size) as total_deal_amt
                    FROM        deals
                    GROUP BY    employee_id)

SELECT      sales_quotas.employee_id, 
            CASE WHEN total_deal_amt >= quota THEN 'yes' ELSE 'no' END AS made_quota 

-- We need this INNER JOIN statement to obtain the quota for each employee
-- With this INNER JOIN, we can finally compare each employee's quota to the total amount of deals they got.
FROM        sales_quotas
INNER JOIN  total_deals
ON          sales_quotas.employee_id = total_deals.employee_id
ORDER BY    employee_id
