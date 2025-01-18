/*
What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst position
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts
and helps identify the most financially rewarding skills to acquire or improve
*/

select
    skills,
    round(avg(salary_year_avg), 0) as skill_salary
from 
    job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg is not null
group BY
    skills
ORDER BY
    skill_salary DESC
limit 25;

/*
# Key Trends for Top-Paying Data Analyst Skills

1. **Emerging Tech Leads**: Blockchain (**Solidity**, $179K) and AI/ML frameworks (**MXNet**, **Hugging Face**, $123K+) dominate, 
reflecting demand for cutting-edge expertise in Web3 and AI-driven solutions.

2. **Infrastructure and Automation Dominate**: High salaries for skills like **Terraform** ($146K), **Puppet** ($129K),
 and **Airflow** ($116K) highlight the focus on scalable cloud deployment and data pipeline automation.

3. **Versatility Matters**: Expertise in niche databases (**Couchbase**, $160K),
 collaborative tools (**GitLab**, $134K), and versatile programming languages (**Golang**, $155K) ensures strong earning potential.
[
  {
    "skills": "svn",
    "skill_salary": "400000"
  },
  {
    "skills": "solidity",
    "skill_salary": "179000"
  },
  {
    "skills": "couchbase",
    "skill_salary": "160515"
  },
  {
    "skills": "datarobot",
    "skill_salary": "155486"
  },
  {
    "skills": "golang",
    "skill_salary": "155000"
  },
  {
    "skills": "mxnet",
    "skill_salary": "149000"
  },
  {
    "skills": "dplyr",
    "skill_salary": "147633"
  },
  {
    "skills": "vmware",
    "skill_salary": "147500"
  },
  {
    "skills": "terraform",
    "skill_salary": "146734"
  },
  {
    "skills": "twilio",
    "skill_salary": "138500"
  },
  {
    "skills": "gitlab",
    "skill_salary": "134126"
  },
  {
    "skills": "kafka",
    "skill_salary": "129999"
  },
  {
    "skills": "puppet",
    "skill_salary": "129820"
  },
  {
    "skills": "keras",
    "skill_salary": "127013"
  },
  {
    "skills": "pytorch",
    "skill_salary": "125226"
  },
  {
    "skills": "perl",
    "skill_salary": "124686"
  },
  {
    "skills": "ansible",
    "skill_salary": "124370"
  },
  {
    "skills": "hugging face",
    "skill_salary": "123950"
  },
  {
    "skills": "tensorflow",
    "skill_salary": "120647"
  },
  {
    "skills": "cassandra",
    "skill_salary": "118407"
  },
  {
    "skills": "notion",
    "skill_salary": "118092"
  },
  {
    "skills": "atlassian",
    "skill_salary": "117966"
  },
  {
    "skills": "bitbucket",
    "skill_salary": "116712"
  },
  {
    "skills": "airflow",
    "skill_salary": "116387"
  },
  {
    "skills": "scala",
    "skill_salary": "115480"
  }
]
*/
