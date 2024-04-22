-- First we want a way to determine what the launch month is for each card. 
-- We can achieve this by appending a ROW_NUMBER() to each row, where 1 denotes the launch month
WITH card_ranking as    (SELECT     *,
                                    ROW_NUMBER() OVER (PARTITION BY card_name ORDER BY issue_year, issue_month ASC) AS ranking
                                    -- We partition by card_name to get a separate ranking for each card.
                                    -- We order by issue_month ASC so that the earliest time has ranking 1. 
                        FROM        monthly_cards_issued) 

SELECT      card_name, 
            issued_amount 
FROM        card_ranking
WHERE       ranking = 1 -- We only want the launch month for each card, which will always have a ranking of 1.
ORDER BY    issued_amount DESC