-- Following queries results were exported to use in Tableau Public for visualisation

-- Tableau Table 1
SELECT
	date,
    new_cases,
    new_deaths,
   (new_deaths/new_cases) * 100 AS death_percentage
FROM deaths
WHERE continent IS NOT NULL
GROUP BY date, new_cases, new_deaths; 

-- Tableau Table 2
SELECT
  location,
  MAX(total_deaths) AS total_deaths
FROM deaths
WHERE continent IS NULL
	AND location NOT IN ('World', 'International', 'European Union')
GROUP BY location
ORDER BY total_deaths DESC;

-- Tableau Table 3
SELECT 
	location,
    population,
    MAX(total_cases) AS highest_infection_count,
    (MAX(total_cases)/population) * 100 AS positive_pop_percentage
FROM deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY positive_pop_percentage DESC;

-- Tableau Table 4
Select 
	location, 
    population,
    date,
    MAX(total_cases) as highest_infection_count,
    (MAX(total_cases)/population)*100 as PercentPopulationInfected
From deaths
Group by Location, Population, date
order by PercentPopulationInfected DESC;
