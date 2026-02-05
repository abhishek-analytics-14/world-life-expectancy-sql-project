-- World Life Expectancy Project (Data Cleaning)

CREATE DATABASE IF NOT EXISTS world_life_expectancy;
USE world_life_expectancy;

SELECT * 
FROM worldlifeexpectancy;

SELECT Country, Year, CONCAT(Country, Year), COUNT(CONCAT(Country, Year))
FROM worldlifeexpectancy
GROUP BY Country, Year, CONCAT(Country, Year)
HAVING COUNT(CONCAT(Country, Year))> 1
;

SELECT *
FROM (
	SELECT ROW_ID, 
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS ROW_NUM
	FROM worldlifeexpectancy 
	) AS Row_table
WHERE ROW_NUM > 1
; 

DELETE FROM worldlifeexpectancy
WHERE 
	ROW_ID IN (
    SELECT ROW_ID
FROM (
	SELECT ROW_ID, 
	CONCAT(Country, Year),
	ROW_NUMBER() OVER(PARTITION BY CONCAT(Country, Year) ORDER BY CONCAT(Country, Year)) AS ROW_NUM
	FROM worldlifeexpectancy 
	) AS Row_table
WHERE ROW_NUM > 1
    );
    
SELECT * 
FROM worldlifeexpectancy
WHERE STATUS = ''
;

SELECT DISTINCT(Status) 
FROM worldlifeexpectancy
WHERE STATUS <> ''
;

SELECT DISTINCT(Country)
FROM worldlifeexpectancy
WHERE Status = 'Developing';

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.country = t2.country 
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

SELECT * 
FROM worldlifeexpectancy 
WHERE Country = 'United States of America';

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.country = t2.country 
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

SELECT * 
FROM worldlifeexpectancy
WHERE `Life expectancy` = ''
;

SELECT t1.Country, t1.Year, t1.`Life expectancy`,
t2.Country, t2.Year, t2.`Life expectancy`,
t3.Country, t3.Year, t3.`Life expectancy`,
ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
FROM worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.country = t2.country 
    AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3
	ON t1.country = t3.country 
    AND t1.Year = t3.Year + 1
WHERE t1.`Life expectancy` = ''
;

UPDATE worldlifeexpectancy t1
JOIN worldlifeexpectancy t2
	ON t1.country = t2.country 
    AND t1.Year = t2.Year - 1
JOIN worldlifeexpectancy t3
	ON t1.country = t3.country 
    AND t1.Year = t3.Year + 1
SET t1.`Life expectancy` = ROUND((t2.`Life expectancy` + t3.`Life expectancy`) / 2, 1)
WHERE t1.`Life expectancy` = ''
;

SELECT * 
FROM worldlifeexpectancy;


-- World Life Expectancy Project (Exploratory Data Analysis)

SELECT * 
FROM worldlifeexpectancy;

-- Checking the change in life expectancy 
SELECT Country, 
MIN(`Life expectancy`) AS Min_Life_Expectancy, 
MAX(`Life expectancy`) AS Max_Life_Expectancy,
ROUND(MAX(`Life expectancy`) - MIN(`Life expectancy`),1) AS Change_in_Life_Expectancy 
FROM worldlifeexpectancy
GROUP BY Country 
HAVING MIN(`Life expectancy`) <> 0
AND MAX(`Life expectancy`) <> 0
ORDER BY Change_in_Life_Expectancy DESC
;

-- Average life expectancy by year
SELECT Year, ROUND(AVG(`Life expectancy`),2) AS Average_life_expectancy 
FROM worldlifeexpectancy
WHERE `Life expectancy` <> 0
GROUP BY Year
ORDER BY Year;

SELECT * 
FROM worldlifeexpectancy;

-- Is there a correlation between GDP and life expectancy 
SELECT Country, ROUND(AVG(`Life expectancy`),2) AS Avg_Life_Expectancy , ROUND(AVG(GDP), 1) AS Avg_GDP 
FROM worldlifeexpectancy
GROUP BY Country
HAVING AVG(`Life expectancy`) > 0 
AND AVG(GDP) > 0
ORDER BY AVG(GDP) ASC;
# We can clearly see that there is a positive correlation between the two.

SELECT SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count, 
	AVG(CASE WHEN GDP >= 1500 THEN `Life expectancy` ELSE 0 END) High_GDP_Life_Expectancy,
    SUM(CASE WHEN GDP < 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
    AVG(CASE WHEN GDP < 1500 THEN `Life expectancy` ELSE 0 END) Low_GDP_Life_Expectancy
FROM worldlifeexpectancy;

-- Digging deeper into Status
SELECT Status, ROUND(AVG(`Life expectancy`), 2)
FROM worldlifeexpectancy
GROUP BY Status;

SELECT Status, COUNT(DISTINCT Country), ROUND(AVG(`Life expectancy`), 2)
FROM worldlifeexpectancy
GROUP BY Status;

-- Looking at the BMI 
SELECT Country, 
	ROUND(AVG(`Life expectancy`), 2) AS Avg_Life_Expectancy, 
    ROUND(AVG(BMI), 2) AS Avg_BMI
FROM worldlifeexpectancy
GROUP BY Country 
HAVING AVG(BMI) <> 0 
AND AVG(`Life expectancy`) <> 0 
ORDER BY Avg_BMI ASC;

-- Rolling Total

SELECT Country, 
Year, 
`Life expectancy`,
`Adult Mortality`,
SUM(`Adult Mortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_total
FROM worldlifeexpectancy
WHERE COUNTRY LIKE '%United%'
;


