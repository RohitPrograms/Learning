-- First, I am getting the total number of likes associated with each page from the page_likes table
WITH total_likes AS (SELECT     page_id, 
                                COUNT(page_id) AS num_likes 
                    FROM        page_likes 
                    GROUP BY    page_id)

-- Next, I am performing a LEFT JOIN to get all of the pages from the pages table.
-- I am using LEFT instead of INNER because some pages may not have received any likes. 
-- If this is the case, that page would not be in the page_likes table.
SELECT      pages.page_id 
FROM        pages LEFT JOIN total_likes
ON          pages.page_id = total_likes.page_id
WHERE       num_likes IS NULL -- From our LEFT JOIN, we know that the pages without any likes will have a NULL value for num_likes.