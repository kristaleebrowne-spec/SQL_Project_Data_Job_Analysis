/*

-- subquery in FROM clause example

SELECT *
FROM ( -- subquery starts here
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
        ) AS January_Jobs; -- subquery ends here


-- CTE example

WITH January_Jobs AS (
        SELECT *
        FROM job_postings_fact
        WHERE EXTRACT(MONTH FROM job_posted_date) = 1
        )

SELECT *
FROM 
    January_Jobs;


-- subquery in WHERE clause example

SELECT 
    name AS company_name,
    company_id
FROM 
    company_dim
WHERE company_id IN (
        SELECT -- subquery for all companies that don't require a degree
            company_id
        FROM
            job_postings_fact
        WHERE
            job_no_degree_mention = true
        ORDER BY company_id
        );


-- Practice query
-- find the companies that have the most job openings
-- get total number of job postings per company company_id
-- return the total number of jobs with the company name
*/

-- Answer using a CTE

-- CTE to count number of jobs per company

WITH total_jobs_company AS (
    SELECT
        company_id,
        COUNT(*) AS number_of_jobs
    FROM
        job_postings_fact
    GROUP BY
        company_id
    )

SELECT
    cd.name AS Company_Name,
    tjc.number_of_jobs AS Number_of_Jobs
FROM
    company_dim cd 
LEFT JOIN total_jobs_company tjc USING(company_id)
ORDER BY
    Number_of_Jobs DESC;



-- answer using a left join / no CTE

 SELECT
    cd.name AS Company_Name,
    COUNT(jpf.*) AS Number_of_Jobs
 FROM
    company_dim cd
 LEFT JOIN 
    job_postings_fact jpf USING(company_id)
GROUP BY
    cd.name
ORDER BY
    Number_of_Jobs DESC;
