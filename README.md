# Introduction
📊 Explore the data job market with a focus on data analyst roles! This project highlights:
💰 The highest-paying positions
🔥 The most sought-after skills
📈 Where high demand aligns with top salaries in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining other work to find optimal jobs.

The data are from Luke Barousse's [SQL course](https://lukebarousse.com/sql). It's packed with insights on job titles, salaries, locations, and essential skills.
The data was scraped from LinkedIn job postings.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data jobs in Hungary?
2. What skills are required for top-paying data analyst jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I used
For my deep dive into the data analyst job market, I used several tools to find my answers:

- **<U>SQL</U>**: The backbone of my analysis allows me to query the database and unearth critical insights.
- **<U>PostgreSQL</U>**: The chosen database management system, ideal for handling the job posting data.
- **<U>Visual Studio Code</U>**: My go-to for database management and executing SQL queries.
- **<U>Git & GitHub</U>**: Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query of this project aimed at investigating specific aspects of the data analyst job market.
Here's how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered the data positions by average yearly salary and location, focusing on jobs in Hungary. This query highlights the high-paying opportunities in the field.

```sql
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
    salary_year_avg desc;
```
Here's the breakdown of the top data jobs in 2023 in Hungary:
- **Not too wide selection:** We found 12 job postings in Hungary with the word 'Data' in the title and salaries ranging from $70.000 to $155.000.
- **3 Man show:** In this database, only three companies represented the job market in Hungary: Deutsche Telekom IT Solutios with eight job postings, Exadel with 2 job postings, and OTP Bank with two job postings, one with the highest salary and one with the second lowest.
- **Job Title Variety:** More than half of the job postings were looking for Data Engineers, and the job posting covered roles from senior to lead.

#### <u>Initially, I wanted to focus on the Hungarian job market. Since it lacked high-volume data, I stayed with the worldwide database from the second question to focus more on the Data Analyst job postings.</u>

### 2.What skills are required for top-paying data analyst jobs?
I joined all the tables to understand what skills are required for top-paying jobs, providing insights into what specific companies would pay for a position requiring the needed skills.

```sql
With top_paying_jobs as (
SELECT
    job_id,
    Job_title,
    salary_year_avg,
    name as Company_name
from
    job_postings_fact
LEFT JOIN
    company_dim 
    on job_postings_fact.company_id = company_dim.company_id
where
    job_title_short = 'Data Analyst'
    AND
    job_location = 'Anywhere'
    AND
    salary_year_avg is not null
order BY
    salary_year_avg desc
limit 10
)
select 
    top_paying_jobs.*,
    skills
from 
    top_paying_jobs
inner JOIN skills_job_dim on top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
order BY
    salary_year_avg desc;
```

By breaking down the data we found the following results:
- SQL is the most in demand skill with the count of 8.
- Python is the following with the count of 7.
- Tableau is the third in the list with 6.
- Others skills that are not in the top 3 but still in high demand are R; Snowflake; Pandas and Excel.


![Top 10 Paying Data Analyst jobs skill count](assets\2_top_paying_roles_skills.png)
*Bar graph visualizing the count of skills for the top 10 paying jobs for data analysts; ChatGPT generated this graph from my SQL query*

### 3.What skills are most in demand for data analysts?


This query helped pinpoint the skills most commonly sought in job postings, allowing for a focus on high-demand areas.

```SQL
select
    skills,
    count(skills_job_dim.job_id) as demand_count
from 
    job_postings_fact
inner JOIN skills_job_dim on job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    job_work_from_home = true
group BY
    skills
order by
    demand_count desc
limit 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023

- **SQL** and **Excel** continue to be foundational, highlighting the importance of strong data processing and spreadsheet management skills.
- **Programming** and visualization tools such as **Python**, **Tableau**, and **Power BI** are key, highlighting the growing importance of technical expertise in data storytelling and decision support.

| Skills    | Demand Count |
|-----------|--------------|
| SQL       | 7291         |
| Excel     | 4611         |
| Python    | 4330         |
| Tableau   | 3745         |
| Power BI  | 2609         |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4.Which skills are associated with higher salaries?
Analyzing the average salaries for various skills revealed the highest-paying ones.
```sql
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
```

Key Trends for Top-Paying Data Analyst Skills

1. **<u>Emerging Tech Leads</u>**: Blockchain (**Solidity**, $179K) and AI/ML frameworks (**MXNet**, **Hugging Face**, $123K+) dominate, 
reflecting demand for cutting-edge expertise in Web3 and AI-driven solutions.

2. **<u>Infrastructure and Automation Dominate</u>**: High salaries for skills like **Terraform** ($146K), **Puppet** ($129K),
 and **Airflow** ($116K) highlight the focus on scalable cloud deployment and data pipeline automation.

3. **<u>Versatility Matters</u>**: Expertise in niche databases (**Couchbase**, $160K),
 collaborative tools (**GitLab**, $134K), and versatile programming languages (**Golang**, $155K) ensures strong earning potential.

| Skills       | Skill Salary |
|--------------|--------------|
| SVN          | 400,000      |
| Solidity     | 179,000      |
| Couchbase    | 160,515      |
| DataRobot    | 155,486      |
| Golang       | 155,000      |
| MXNet        | 149,000      |
| dplyr        | 147,633      |
| VMware       | 147,500      |
| Terraform    | 146,734      |
| Twilio       | 138,500      |
| GitLab       | 134,126      |
| Kafka        | 129,999      |
| Puppet       | 129,820      |
| Keras        | 127,013      |
| PyTorch      | 125,226      |

*Table of the average salary for the top 15 paying skills for data analysts*

### 5. What are the most optimal skills to learn?
This query combined demand and salary data to identify highly sought-after skills and offer high salaries, providing a strategic direction for skill development.

*With this query, I liked the option to access the problem in multiple ways. Here, I will showcase the query that I optimized, but you will find three versions of it in the files in which I tried to solve the question.*
```SQL
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
```

Here's a breakdown of the most optimal skills for Data Analysts in 2023:
- **<u>High-Demand Programming Languages:</u>** Python and R are in high demand, with demand counts of 236 and 148, respectively. Although their average salaries are approximately $101,397 for Python and $100,499 for R, indicating firm valuation, their widespread usage means proficiency in these languages is highly sought after and commonly available.
- **<u>Cloud Tools and Technologies:</u>** Expertise in cloud technologies such as Snowflake, Azure, AWS, and BigQuery is in significant demand, with relatively high average salaries. This trend highlights the increasing importance of cloud platforms and big data technologies in data analysis.
- **<u>Business Intelligence and Visualization Tools:</u>** Tools like Tableau and Looker, with demand counts of 230 and 49 and average salaries of $99,288 and $103,795, respectively, underscore the crucial role of data visualization and business intelligence in extracting actionable insights from data.
- **<u>Database Technologies:</u>** Skills in both traditional and NoSQL databases (Oracle, SQL Server, NoSQL) remain in demand, with average salaries ranging from $97,786 to $104,534. This reflects the ongoing need for expertise in data storage, retrieval, and management.

| Skills        | Demand Count | Avg Salary |
|---------------|--------------|------------|
| Go            | 27           | 115,320    |
| Confluence    | 11           | 114,210    |
| Hadoop        | 22           | 113,193    |
| Snowflake     | 37           | 112,948    |
| Azure         | 34           | 111,225    |
| BigQuery      | 13           | 109,654    |
| AWS           | 32           | 108,317    |
| Java          | 17           | 106,906    |
| SSIS          | 12           | 106,683    |
| Jira          | 20           | 104,918    |

*Table of the most optimal skills for data analyst sorted by salary*

# What I Learned - My Achievements🛡️
Since I jumped into this course with simple basic SQL knowledge I had the opportunity to extend my SQL toolkit with advanced functions.
- 🧙‍♂️SQL Wizardry: Learned to use the basic formulas in real-life scenarios and obtained knowledge of how to use even advanced CTEs and Subqueries.
- ⚙️Troubleshooter Master: I honed my ability to take a step back and see the bigger picture so I could become an in-flesh troubleshooter.
- 🪖JOIN Commander: I got comfortable with the JOIN function to oversee even bigger databases.

# Conclusions

Key Insights
From the analysis, several key takeaways emerged:

1. According to the used database, Hungary does not have the most tremendous amount of data about data jobs. 

2. Flexibility and Competitive Salaries: Remote data analyst positions offer a wide salary range, and most high-paying jobs don't require you to work on-site!

3. Skills for Top-Paying Roles: Advanced proficiency in SQL is crucial for securing high-paying data analyst positions, making it an essential skill for top earnings.

4. Most In-Demand Skills: SQL is also in high demand within the data analyst job market, solidifying its importance for job seekers.

5. Specialized Skills with Higher Salaries: Niche skills like SVN and Solidity are linked to the highest average salaries, showcasing the value of specialized expertise.

6. Optimal Skills for Market Value: SQL stands out as both the most in-demand and high-paying skill, positioning it as a key asset for data analysts aiming to maximize their career potential.

## Closing Thoughts
This project helped me showcase my SQL knowledge while giving me insights about the job market in the Data Analysis industry. The most needed skills, such as SQL, Python, Excel, and visualization tools, will always be the most important fundamentals for anyone pursuing this career. But extending our skills is a must to aim for higher salaries and the most prestigious positions!
