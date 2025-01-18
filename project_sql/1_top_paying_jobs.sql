/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available in Hungary.
- Focuses on job postings with specified salaries (remove nulls)
*/

SELECT
    job_id,
    Job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name as Company_name
from
    job_postings_fact
LEFT JOIN
    company_dim 
    on job_postings_fact.company_id = company_dim.company_id
where
    job_title_short like '%Data%'
    AND
    job_location = 'Hungary'
    AND
    salary_year_avg is not null
order BY
    salary_year_avg desc
limit 10

