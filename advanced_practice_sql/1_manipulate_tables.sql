
-- january
CREATE TABLE jobs_january AS
    SELECT *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 1;


--February
CREATE TABLE jobs_february AS
    SELECT *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE jobs_march AS
    SELECT *
    FROM
        job_postings_fact
    WHERE
        EXTRACT(MONTH FROM job_posted_date) = 3;
