-- If we take the difference between the total number of job postings and the total number of UNIQUE job postings, we would get the number of duplicate postings.
-- According to the problem statment, Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.

-- Therefore, if we count the distinct number of (company_id, title, description) triplets, we would get the number of distinct job listings.
-- COUNT(*), however, gets the total number of job listings (not necessarily unique) 
-- This difference would give is the number of duplicate postings.


SELECT      COUNT(*) - COUNT(DISTINCT(company_id, title, description)) AS duplicate_companies
FROM        job_listings