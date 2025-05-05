# Road Accident Data Analysis with SQL

## Project Overview
This project explores a global road accident dataset using **Microsoft SQL Server**, focusing on trends, fatality rates, safety measures, and accident types. It leverages **CTEs, window functions, and subqueries** to draw meaningful insights that can support policy planning and safety interventions.

## Dataset Overview

The dataset contains the following columns:

- `Country` – Name of the country  
- `Year` – Year of the record  
- `Accidents Reported` – Number of accidents recorded  
- `Fatalities` – Number of deaths recorded  
- `Injuries` – Number of injuries recorded  
- `Accident Type` – Nature/type of the accident  
- `Road Safety Measures` – Type/level of safety measures applied  

##  Key Exploratory Questions Answered

1.  **Accident Trend Over the Years**  
2.  **Country-Wise Analysis of Accidents, Fatalities & Injuries**  
3.  **Impact of Different Accident Types**  
4.  **Effectiveness of Road Safety Measures**  
5.  **Proportion of Total Fatalities by Accident Type**  
6. **Fatality Rate by Accident Type**  
7.  **Fatality Rate vs Reported Accidents (Yearly)**  
8.  **Yearly Ranking of Total Accidents**  
9.  **Country with the Most Accidents**  
10.  **Ranking of Accident Types by Total Fatalities**  
11.  **Comparison of Safety Measure Effectiveness Across Countries**  
12.  **Year with the Highest Reported Injuries**



## SQL Concepts & Techniques Used

- ✅ **Common Table Expressions (CTEs)**  
- ✅ **Window Functions** (`RANK()` etc.)  
- ✅ **Subqueries**   
- ✅ **Aggregations & Grouping**  
 
## Tools & Tech

- **Microsoft SQL Server Management Studio (SSMS)**
- **T-SQL** for querying and transformations
  
## Sample Query Snippet

```sql
WITH AccidentRank AS (
  SELECT 
    Year,
    Country,
    AccidentsReported,
    RANK() OVER(PARTITION BY Year ORDER BY AccidentsReported DESC) AS YearlyAccidentRank
  FROM AccidentData
)
SELECT * FROM AccidentRank WHERE YearlyAccidentRank = 1;
