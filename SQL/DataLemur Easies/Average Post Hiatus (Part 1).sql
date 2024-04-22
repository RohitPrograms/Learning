WITH days_between_table AS  (SELECT     DISTINCT    user_id,
                                        EXTRACT(DAY FROM MAX(post_date) OVER (PARTITION BY user_id) - MIN(post_date) OVER (PARTITION BY user_id)) AS days_between
                                        -- Here, I am utilizing window functions to get the min/max post_date for each user_id
                                        -- Afterwards, I am using the EXTRACT DAY keyphrase to get the difference (in days) between the min and max post_date
                            FROM        posts
                            WHERE       EXTRACT(YEAR FROM post_date) = 2021 -- Making sure we are only looking at posts from 2021
                            )

SELECT      * 
FROM        days_between_table 
WHERE       days_between != 0 -- If the difference between the min and max post_date is 0 for a given user, that implies that they are the same, meaning that the user only posted once that year
ORDER BY    days_between DESC