-- ¿Cuales son las habiidades más optimas para aprender?,
    -- Optimo: alta demanda con alta remuneraión.

WITH combined_data AS ( -- aplicamos un conjunto de CTE
    SELECT
        sd.skill_id,
        sd.skills,
        COUNT(sj.skill_id) AS demand_count,
        ROUND(AVG(jp.salary_year_avg), 0) AS avg_salary
    FROM
        skills_dim sd
    INNER JOIN skills_job_dim sj ON sj.skill_id = sd.skill_id
    INNER JOIN job_postings_fact jp ON jp.job_id = sj.job_id
    WHERE
        jp.job_work_from_home = TRUE AND
        jp.job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY sd.skill_id
), ranked_skills AS (
    SELECT
        skill_id,
        skills,
        demand_count,
        avg_salary,
        ROW_NUMBER() OVER (ORDER BY avg_salary DESC, demand_count DESC) AS rank
    FROM
        combined_data
    WHERE
        demand_count > 10
)
SELECT
    skill_id,
    skills,
    demand_count,
    avg_salary
FROM
    ranked_skills
WHERE
    rank <= 30
ORDER BY
    rank ASC;

/*
Resultados del analisis de datos:
    - Habilidades de alta demanda generalmente tienen salarios más altos:
        Habilidades como Python, SQL y Tableau, que tienen constantemente altas demandas, también tienen salarios promedio relativamente altos.
    
    - La demanda de ciertas habilidades está aumentando:
        Habilidades como Go y Snowflake han visto un aumento significativo en la demanda, lo que posiblemente indica tendencias crecientes en la industria o avances tecnológicos.
    
    - Las habilidades especializadas pueden ser lucrativas:
        Mientras que las habilidades más generales como SQL y Python tienen alta demanda, las habilidades especializadas como Looker y Confluence también pueden ofrecer salarios competitivos debido a su naturaleza de nicho.
*/
;;
/*
[
  {
    "skill_id": 8,
    "skills": "go",
    "demand_count": "27",
    "avg_salary": "115320"
  },
  {
    "skill_id": 234,
    "skills": "confluence",
    "demand_count": "11",
    "avg_salary": "114210"
  },
  {
    "skill_id": 97,
    "skills": "hadoop",
    "demand_count": "22",
    "avg_salary": "113193"
  },
  {
    "skill_id": 80,
    "skills": "snowflake",
    "demand_count": "37",
    "avg_salary": "112948"
  },
  {
    "skill_id": 74,
    "skills": "azure",
    "demand_count": "34",
    "avg_salary": "111225"
  },
  {
    "skill_id": 77,
    "skills": "bigquery",
    "demand_count": "13",
    "avg_salary": "109654"
  },
  {
    "skill_id": 76,
    "skills": "aws",
    "demand_count": "32",
    "avg_salary": "108317"
  },
  {
    "skill_id": 4,
    "skills": "java",
    "demand_count": "17",
    "avg_salary": "106906"
  },
  {
    "skill_id": 194,
    "skills": "ssis",
    "demand_count": "12",
    "avg_salary": "106683"
  },
  {
    "skill_id": 233,
    "skills": "jira",
    "demand_count": "20",
    "avg_salary": "104918"
  },
  {
    "skill_id": 79,
    "skills": "oracle",
    "demand_count": "37",
    "avg_salary": "104534"
  },
  {
    "skill_id": 185,
    "skills": "looker",
    "demand_count": "49",
    "avg_salary": "103795"
  },
  {
    "skill_id": 2,
    "skills": "nosql",
    "demand_count": "13",
    "avg_salary": "101414"
  },
  {
    "skill_id": 1,
    "skills": "python",
    "demand_count": "236",
    "avg_salary": "101397"
  },
  {
    "skill_id": 5,
    "skills": "r",
    "demand_count": "148",
    "avg_salary": "100499"
  },
  {
    "skill_id": 78,
    "skills": "redshift",
    "demand_count": "16",
    "avg_salary": "99936"
  },
  {
    "skill_id": 187,
    "skills": "qlik",
    "demand_count": "13",
    "avg_salary": "99631"
  },
  {
    "skill_id": 182,
    "skills": "tableau",
    "demand_count": "230",
    "avg_salary": "99288"
  },
  {
    "skill_id": 197,
    "skills": "ssrs",
    "demand_count": "14",
    "avg_salary": "99171"
  },
  {
    "skill_id": 92,
    "skills": "spark",
    "demand_count": "13",
    "avg_salary": "99077"
  },
  {
    "skill_id": 13,
    "skills": "c++",
    "demand_count": "11",
    "avg_salary": "98958"
  },
  {
    "skill_id": 186,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 7,
    "skills": "sas",
    "demand_count": "63",
    "avg_salary": "98902"
  },
  {
    "skill_id": 61,
    "skills": "sql server",
    "demand_count": "35",
    "avg_salary": "97786"
  },
  {
    "skill_id": 9,
    "skills": "javascript",
    "demand_count": "20",
    "avg_salary": "97587"
  },
  {
    "skill_id": 183,
    "skills": "power bi",
    "demand_count": "110",
    "avg_salary": "97431"
  },
  {
    "skill_id": 0,
    "skills": "sql",
    "demand_count": "398",
    "avg_salary": "97237"
  },
  {
    "skill_id": 215,
    "skills": "flow",
    "demand_count": "28",
    "avg_salary": "97200"
  },
  {
    "skill_id": 201,
    "skills": "alteryx",
    "demand_count": "17",
    "avg_salary": "94145"
  },
  {
    "skill_id": 199,
    "skills": "spss",
    "demand_count": "24",
    "avg_salary": "92170"
  }
]
*/