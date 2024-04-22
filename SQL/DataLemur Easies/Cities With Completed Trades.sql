SELECT      city, 
            COUNT(*)
FROM        trades 
INNER JOIN  users
ON          trades.user_id = users.user_id
WHERE       status = 'Completed' -- We are only worried about counting Completed trades here
GROUP BY    city
ORDER BY    COUNT(*) DESC
LIMIT       3