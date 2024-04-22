-- We only care if an email_id has been confirmed, not how many many attempts is took to get confirmed.
-- This will get the email_ids that have been confirmed.
WITH confirmations AS (SELECT   * 
                      FROM      texts 
                      WHERE     signup_action = 'Confirmed')

-- We can now perform eamils LEFT JOIN confirmations, since this will return all of the email_ids, along with the 
-- email_ids that have been confirmed.
-- If an email_id has not been confirmed, we would have a NULL value in the signup_action column.
-- From there, we can obtain a percentage of email_ids that have been confirmed.
SELECT    ROUND(1.0 * SUM(CASE WHEN signup_action IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 2) as confirm_rate 
FROM      emails 
LEFT JOIN confirmations 
ON        emails.email_id = confirmations.email_id