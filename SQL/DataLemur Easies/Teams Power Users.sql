SELECT      sender_id, 
            COUNT(sender_id) AS message_count
FROM        messages
WHERE       EXTRACT(MONTH FROM sent_date) = 8 AND EXTRACT(YEAR FROM sent_date) = 2022 -- This makes sure we are only looking at messages from August 2022
GROUP BY    sender_id
ORDER BY    message_count DESC -- If we want the top 2 message senders, we can ORDER BY message_count DESC and then pick the top 2 rows with LIMIT 2
LIMIT       2