#	Data Cleaning

select * 
from world_life_expectancy;


select Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
from world_life_expectancy
group by Country, Year, CONCAT(Country, Year)
; 

# Delete duplicates
DELETE FROM world_life_expectancy
WHERE Row_ID IN (
	  SELECT Row_ID
      FROM (
			SELECT Row_ID,
			CONCAT(Country, Year),
			ROW_NUMBER() OVER( PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) as Row_Num
			FROM world_life_expectancy
	  ) AS Row_table
      WHERE Row_Num > 1
);
# REPLACE BLANKS IN STATUS BY Developing
UPDATE world_life_expectancy c1
JOIN world_life_expectancy c2
ON c1.Country = c2.Country
SET c1.Status = 'Developing'
WHERE c1.Status = ''
AND c2.Status <> ''
AND c2.Status = 'Developing'
;

# Check of blanks in status
SELECT *
FROM world_life_expectancy
WHERE Status= '';

# Check of NULL
SELECT *
FROM world_life_expectancy
WHERE Status is NULL;

#Check of blanks in Life expectancy
Select *
FROM world_life_expectancy
where `Life expectancy` = ''
;

#Replace blanks values in Life expectancy by Average of LE of last year and next year of the same country

UPDATE world_life_expectancy t1 join world_life_expectancy t2 
ON t1.Country = t2.Country and t1.Year = t2.Year-1
join world_life_expectancy t3
ON t1.Country= t3.Country and t1.Year= t3.Year+1
SET t1.`Life expectancy` = ROUND ((t2.`Life expectancy` +t3.`Life expectancy`)/2)
WHERE t1.`Life expectancy` = ''
;

select *
from world_life_expectancy;
     
     
     
     
#END OF CLEANING


#DATA ANALYSIS


SELECT Country,
MIN(`Life expectancy`),
MAX(`Life expectancy`),
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) as Life_Increase_15_YEARS
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Life_Increase_15_Years ASC 
;


SELECT Year, ROUND(AVG(`Life expectancy`),2)
FROM world_life_expectancy
where `Life expectancy` <> 0
group by Year
Order by Year
;


SELECT Country , ROUND(AVG(`Life expectancy`),1) as Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM world_life_expectancy
group by Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;


SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE 0 END) High_GDP_Life_Expectancy,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) LOW_GDP_Count,
AVG(CASE WHEN GDP <= 1500 THEN `Life expectancy` ELSE 0 END) LOW_GDP_Life_Expectancy
FROM world_life_expectancy
;

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`,1))
FROM world_life_expectancy
GROUP BY Status
;

SELECT Country , ROUND(AVG(`Life expectancy`),1) as Life_Exp, ROUND(AVG(BMI),1) AS GDP
FROM world_life_expectancy
group by Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;


SELECT Country , Year, `Life expectancy`, 	`Adult Mortality`, SUM(`Adult Mortality`)
Over(PARTITION BY Country ORDER BY Year) As Rolling_Total
FROM world_life_expectancy
;
