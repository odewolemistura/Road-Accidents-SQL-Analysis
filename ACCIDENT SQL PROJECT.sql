select * from accident_dataset

--Accident trend over years
select sum(fatalities) TotalFatalities,
	sum(injuries) TotalInjuries,
	sum([accidents reported]) TotalAccidents,
	year
FROM Accident_dataset
GROUP BY year
ORDER BY year desc

--country wise analysis
select 
	sum([accidents reported]) TotalAccidents,
	country
FROM Accident_dataset
GROUP BY country
ORDER BY  TotalAccidents desc

--Accident type impact
select [accident type],
	sum(fatalities) TotalFatalities,
	sum(injuries) TotalInjuries
from Accident_dataset
group by [accident type]
order by TotalFatalities

-- Effectiveness of road safety measures
select [road safety measures],
	count([accidents reported]) NumberOfAccident,
	sum(fatalities) TotalFatalities,
	sum(injuries) TotalInjuries
from accident_dataset
group by [road safety measures]
order by NumberOfAccident

--proportion of total Fatility by accident type
select [accident type],
	sum(fatalities) TotalFatalities, 
	format(sum(fatalities)/(select sum(fatalities) from Accident_dataset), 'p') as FatalityRate
from Accident_dataset
group by [Accident Type]

--fatality rate by accident type
select [accident type],
	sum(fatalities) TotalFatalities, 
	sum([accidents reported]) totalAccident,
	format(sum(fatalities)/sum([accidents reported]), 'p') as FatalityRate
from Accident_dataset
group by [Accident Type]

--fatality rate over accident reported in each year (without CTE)
select year,
	sum(fatalities) TotalFatalities,
	FORMAT(sum(fatalities)/NULLIF(sum([accidents reported]),0),'P') FatalityRate
from Accident_dataset
group  by year
order by yeAR;

--USE CTE
WITH yearlyaccident as (SELECT year,
	sum(fatalities) as TotalFatalities,
	SUM([accidents reported]) as TotalAccident
from accident_dataset
Group by Year)
SELECT year,
	format(totalfatalities/totalaccident, 'p')
from yearlyaccident


--Ranking total accidents by year
WITH YearlyAccidents AS (select year,
	sum([accidents reported]) as totalaccident
from Accident_dataset
group by year)
SELECT *,
RANK () over (order by totalaccident desc) as accidentrank
from YearlyAccidents

--COUNTRY WITH THE MOST ACCIDENT
Select top 1 country,
 sum([accidents reported]) as TotalAccident
from Accident_dataset
group by country
order by  sum([accidents reported]) desc;

-- using CTE
WITH cte_country as (Select country,
 sum([accidents reported]) as TotalAccident
from Accident_dataset
group by country
)
select top 1 country, totalaccident from cte_country  order by TotalAccident desc;

--another long way to go about it
WITH cte_country as (Select country,
 sum([accidents reported]) as TotalAccident
from Accident_dataset
group by country
),
cte_rank as (select country,  totalaccident,
rank () over (order by totalaccident desc) as rank 
from cte_country)
select totalaccident,country from cte_rank where rank =1

--ACCIDENT TYPE RANK TO TOTAL FATALITIES
with cte_fatality as (
SELECT [accident type],
	SUM(fatalities) TotalFatalities
from Accident_dataset
group by [accident type])
select *,
	rank() over (order by totalfatalities desc) 
from cte_fatality

-- Compare Safety measure effectiveness
select [road safety measures],
	sum(fatalities) TotalFatalities,
	sum([accidents reported]) TotalAccident,
	format (sum(fatalities)/sum([accidents reported]), 'p') as rate
from Accident_dataset
group by [road safety measures]
order by rate desc

--highest injury year
select top 1 year, 
	sum(injuries) as Totalinjuries
from Accident_dataset
group by year
order by totalinjuries desc

--ranking total injuries per year
WITH cte_year as (
select  year, 
	sum(injuries) as Totalinjuries
from Accident_dataset
group by year
)
select year, totalinjuries,
 rank() over (order by  totalinjuries desc) 
from cte_year

-- TO RETURN THE WHOLE RECORDS WITHOUT GROUPING
WITH cte_year as (
select  year, 
	sum(injuries) over (partition by year )as Totalinjuries
from Accident_dataset
)
select year, totalinjuries,
 rank() over (order by  totalinjuries desc) AS POSITION
from cte_year