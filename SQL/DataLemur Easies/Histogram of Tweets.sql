-- Gather every twitter user_id along with the amount of times they tweeted in 2022
WITH tweets_per_user as (SELECT     user_id, 
                                    COUNT(*) AS num_tweets
                        FROM        tweets 
                        WHERE       EXTRACT(YEAR FROM tweet_date) = 2022 -- This is to make sure we only count tweets from 2022 
                        GROUP BY    user_id)  

-- Now, we group by num_tweets to get our tweet buckets, and do a count() to get the number of users with the same num_tweets
SELECT      num_tweets AS tweet_bucket, 
            COUNT(*) AS users_num
FROM        tweets_per_user
GROUP BY    num_tweets -- By doing a group by, num_tweets/tweet_bucket is sorted in ascending order by default.
