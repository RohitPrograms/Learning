SELECT      7, COUNT(DISTINCT front_month.user_id)  -- I use 7 just because the problem states that we are only worreid about the month of July.
                                                    -- The Inner Join below returns all combinations of an action performed in July (front_month) and an action performed in June (previous_month) by the same user.
                                                    -- For this problem, however, I am only concerned whether or not a user performed actions in both June and July, hence the DISTINCT keyword.
FROM        user_actions AS front_month    
INNER JOIN  user_actions AS previous_month  -- With this inner join, I am getting all combinations of an action performed in July (front_month) and an action performed in June (previous_month) by the same user.
                                            -- For example, if a user performed 2 actions in July (a1, a2) and 2 actions in June (b1, b2), 4 instances would be returned.
                                            -- (a1, b1), (a1, b2), (a2, b1), (a2, b2).
ON          (front_month.user_id = previous_month.user_id)
            AND 
            (EXTRACT(MONTH FROM front_month.event_date) = EXTRACT(MONTH FROM previous_month.event_date) + 1)
WHERE       EXTRACT(MONTH FROM front_month.event_date) = 7  -- We are only concerned with the month of July for this problem.