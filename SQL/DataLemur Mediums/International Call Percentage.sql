-- First, I am retrieving all the necessary data.
-- This would just be the country_id of the caller, along with the country_id of the receiver.
WITH info as  (SELECT     caller.country_id AS caller_country, 
                          receiver.country_id AS receiver_country 
              FROM        phone_calls 
              INNER JOIN  phone_info AS caller
              ON          phone_calls.caller_id = caller.caller_id
              INNER JOIN  phone_info AS receiver
              ON          phone_calls.receiver_id = receiver.caller_id)

-- Now, I can just count how many rows have  caller_country != receiver_country, since this implies an international call.
-- I would also divide this by the total number of rows so I can obtain a percentage.
SELECT    ROUND(100.0 * SUM(CASE WHEN caller_country != receiver_country THEN 1 ELSE 0 END) / COUNT(*), 1) AS international_calls_pct
FROM      info