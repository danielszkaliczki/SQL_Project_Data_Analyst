/*
Question: What are the most optimal skills to learn (it's in high demand and high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles.
- Concentrates on remote positions with specified salaries.
- Why? Targets skills that offer job security (high demand) and financial benefits (hihg salary),
offering strategic insights for career development in data analysis.
*/

With demanded_skills as (
select
    skills_dim.skills,
    skills_dim.skill_id,
    count(skills_job_dim.job_id) as demand_count
from 
    job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    job_work_from_home = true
    AND
    salary_year_avg is not null
group BY
    skills_dim.skill_id
),
average_salary as (
    select
    skills_job_dim.skill_id,
    round(avg(job_postings_fact.salary_year_avg), 0) as avg_salary
from 
    job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg is not null
    aND
    job_work_from_home = true
group BY
    skills_job_dim.skill_id
)

select
    demanded_skills.skill_id,
    demanded_skills.skills,
    demanded_skills.demand_count,
    average_salary.avg_salary
from
    demanded_skills
INNER join
    average_salary on demanded_skills.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
order BY
    avg_salary desc,
    demand_count desc

limit 25;

/* -- query #2 - simplified :

WITH demanded_skills AS (
    SELECT
        skills_dim.skills,
        skills_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demand_count,
        ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND
        job_work_from_home = true
        AND
        salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
)
SELECT
    skill_id,
    skills,
    demand_count,
    avg_salary
FROM
    demanded_skills
WHERE
    demand_count > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

*/

/* -- query #3 - optimized :

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    job_work_from_home = true
    AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(skills_job_dim.job_id) > 10
ORDER BY
    avg_salary DESC,
    demand_count DESC
LIMIT 25;

*/