/*
-- write a condition to classify where jobs are located
-- create a new column with following labels:
-- 'anywhere' as 'remote'
-- new york, ny as 'local'
-- otherwise 'onsite'

SELECT
    job_title_short AS Job_Title,
    job_location AS Location,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS Location_Category
FROM
    job_postings_fact


-- count the number of jobs for each of the 3 kinds of locations
-- search for only Data Analyst jobs

SELECT
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS Location_Category,
    COUNT(job_id) AS Number_Jobs
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    Location_Category
ORDER BY    
    Number_Jobs DESC;

-- categorize the salaries from each job posting to see if it fits a desired range
-- put salaries into buckets
-- high > 75001 / standard 50001 - 75000 / low > 50000
*/

SELECT
    COUNT(job_id) AS Number_of_Jobs,
    CASE
        WHEN salary_year_avg < 50000.0 THEN 'Low'
        WHEN salary_year_avg BETWEEN 50001.0 AND 75000.0 THEN 'Standard'
        WHEN salary_year_avg > 75001.0 THEN 'High'
        ELSE 'Unknown'
    END AS Salary_Category
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
    Salary_Category
ORDER BY
    Number_of_Jobs DESC;