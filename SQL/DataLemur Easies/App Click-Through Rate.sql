SELECT      app_id,
            ROUND(100.0 * SUM(CASE WHEN event_type = 'click' THEN 1 ELSE 0 END) / SUM(CASE WHEN event_type = 'impression' THEN 1 ELSE 0 END), 2) as ctr
            -- This formula is given in the problem description (100.0 * number of clicks / number of impressions)
                -- To get the number of clicks and impressions, I utilized the SUM and CASE WHEN keywords. 
                -- Whenever the event_type is 'click', we add 1 to the first SUM CASE WHEN.
                -- Whenever the event_type is 'impression', we add 1 to the second SUM CASE WHEN.
FROM        events
WHERE       EXTRACT(YEAR FROM timestamp) = 2022 -- we are only concerned with data from the year 2022
GROUP BY    app_id
