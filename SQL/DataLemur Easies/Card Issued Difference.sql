SELECT      card_name, 
            MAX(issued_amount) - MIN(issued_amount) as difference
FROM        monthly_cards_issued
GROUP BY    card_name
ORDER BY    difference DESC -- Our GROUP BY ordered our rows by card_name by default, so we need to adjust the ordering.