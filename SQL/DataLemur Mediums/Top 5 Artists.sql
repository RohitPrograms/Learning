-- First, I found it useful to merge the data from the 3 separate tables into one concise table named all_info 
WITH all_info AS    (SELECT     global_song_rank.*, songs.name, artists.* 
                    FROM        global_song_rank 
                    INNER JOIN  songs ON global_song_rank.song_id = songs.song_id
                    INNER JOIN  artists ON songs.artist_id = artists.artist_id
                    ),

-- Next, for each artist, I calculated the number of times their songs hit the top ten
top_ten_occurrences AS  (SELECT     artist_id, 
                                    artist_name, 
                                    SUM(CASE WHEN rank <= 10 THEN 1 ELSE 0 END) AS num_top_ten
                        FROM        all_info
                        GROUP BY    artist_id, artist_name  -- I chose to group by both artist_id and artist_name since there could be 2 artists with the same name.
                        ), 

-- Finally, I used DENSE_RANK() to rank each artist, based on the number of times their songs were in the top 10.
artist_ranking AS   (SELECT     artist_name,
                                DENSE_RANK() OVER (ORDER BY num_top_ten DESC) AS artist_rank
                    FROM        top_ten_occurrences
                    )

-- All that is left is to only select the top 5 artists from artist_ranking
SELECT      * 
FROM        artist_ranking 
WHERE       artist_rank <= 5