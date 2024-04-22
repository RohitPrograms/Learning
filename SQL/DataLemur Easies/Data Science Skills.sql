-- If we are under the assumption that there are no duplicates in the candidates table,
-- we can simply count the instances of 'Python', 'Tableau', and 'PostgreSQL' for each candidate.
WITH skill_count AS     (SELECT     candidate_id, 
                                    COUNT(*) AS num_skills
                        FROM        candidates
                        WHERE       skill IN ('Python', 'Tableau', 'PostgreSQL') -- We only want to keep track of the instances of these skills.
                        GROUP BY    candidate_id)

-- Since the assumption is that there are no duplicates in the candidates table, we know the following is true...
-- If a candidate has a skil_num = 3, that means they have the 'Python', 'Tableau', and 'PostgreSQL' skills.
SELECT      candidate_id 
FROM        skill_count
WHERE       num_skills = 3 -- We do not need an ORDER BY clause since the GROUP BY function from above already achieves that

-- If there were duplicates, a candidate could have a num_skills = 3 but have all 3 of his skills just be 'Python.
-- To deal with duplicates, we can simply change COUNT(*) to COUNT(DISTINCT skill).