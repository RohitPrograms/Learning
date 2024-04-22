SELECT      user_id, 
            tweet_date,
            ROUND(AVG(tweet_count) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3d
            -- ROWS BETWEEN 2 PRECEDING AND CURRENT ROW is analogous to a window frame in which the window function operates.
            -- This means that the AVG(tweet_count) values in row n would be the average of rows n, n-1, and n-2
FROM        tweets
