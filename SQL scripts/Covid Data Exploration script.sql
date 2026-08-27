SELECT *
FROM deaths
WHERE continent IS NOT NULL
ORDER BY location, date;

-- SELECT *
-- FROM vaccinations
-- ORDER BY location, date;

-- Select data that we are going to be using

SELECT 
	location,
    date,
    total_cases,
    new_cases,
    total_deaths,
    population
FROM deaths
ORDER BY location, date;


-- Total Cases vs Total Deaths
-- shows the percentage of positive cases that ended in a death
SELECT 
	location,
    date,
    total_cases,
    total_deaths,
    (total_deaths/total_cases) * 100 AS death_percentage
FROM deaths
WHERE location = 'United Kingdom'
  AND continent IS NOT NULL
ORDER BY location, date;


-- Total cases vs Population
-- percentage of population that contracted Covid-19
SELECT 
	location,
    date,
    population,
    total_cases,
    (total_cases/population) * 100 AS positive_pop_percentage
FROM deaths
WHERE location = 'United Kingdom'
  AND continent IS NOT NULL
ORDER BY location, date;


-- countries with the highest infection rates relative to population

SELECT 
	location,
    population,
    MAX(total_cases) AS highest_infection_count,
    (MAX(total_cases)/population) * 100 AS positive_pop_percentage
FROM deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY positive_pop_percentage DESC;

-- countries with the highest death counts relative to population
SELECT 
	location,
    population,
    MAX(total_deaths) AS deaths,
    (MAX(total_deaths)/population) * 100 AS death_percentage
FROM deaths
WHERE continent IS NOT NULL
GROUP BY location, population
ORDER BY death_percentage DESC;


-- Highest total death countries

SELECT
  location,
  MAX(total_deaths) AS total_deaths
FROM deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_deaths DESC;


-- CONTINENTAL numbers
-- Total deaths by continent

SELECT
  location,
  MAX(total_deaths) AS total_deaths
FROM deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_deaths DESC;


-- GLOBAL numbers
-- death percent globally from positive cases
-- by date

SELECT 
    date,
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    (SUM(new_deaths)/SUM(new_cases)) * 100 AS death_percentage
FROM deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;

-- totals
SELECT 
    SUM(new_cases) AS total_cases,
    SUM(new_deaths) AS total_deaths,
    (SUM(new_deaths)/SUM(new_cases)) * 100 AS death_percentage
FROM deaths
WHERE continent IS NOT NULL;




-- Total populations vs total vaccinations

SELECT
  d.continent,
  d.location,
  d.date,
  d.population,
  v.new_vaccinations
FROM deaths d
JOIN vaccinations v
  USING (location, date)
WHERE d.continent IS NOT NULL
ORDER BY location, date;

SELECT
  d.continent,
  d.location,
  d.date,
  d.population,
  v.new_vaccinations,
  SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vac_count
FROM deaths d
JOIN vaccinations v
  USING (location, date)
WHERE d.continent IS NOT NULL
ORDER BY location, date;


-- We want to use the rolling vac count to calculate the percentange of the population that are vaccinated
-- i have done this using a CTE and a temp table

-- using a CTE

WITH PopVsVac (continent, location, date, population, new_vaccinations, rolling_vac_count)
AS
  (
SELECT
  d.continent,
  d.location,
  d.date,
  d.population,
  v.new_vaccinations,
  SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vac_count
FROM deaths d
JOIN vaccinations v
  USING (location, date)
WHERE d.continent IS NOT NULL
  )

SELECT 
  *,
  (rolling_vac_count/population) * 100 AS percent_vaccinated
FROM popvsvac;


-- using a temp table
DROP TEMPORARY TABLE IF EXISTS percent_population_vaccinated;
CREATE TEMPORARY TABLE percent_population_vaccinated
  (
  continent VARCHAR(255),
  location VARCHAR(255),
  date DATETIME,
  population NUMERIC,
  new_vaccinations NUMERIC,
  rolling_vac_count NUMERIC
  );
INSERT INTO percent_population_vaccinated
  SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vac_count
  FROM deaths d
  JOIN vaccinations v
    USING (location, date)
  WHERE d.continent IS NOT NULL;


SELECT 
  *,
  (rolling_vac_count/population) * 100 AS percent_vaccinated
FROM percent_population_vaccinated;



-- creating a view to export to Tableau for visualisation

CREATE VIEW percent_population_vaccinated 
AS
SELECT
    d.continent,
    d.location,
    d.date,
    d.population,
    v.new_vaccinations,
    SUM(v.new_vaccinations) OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vac_count
  FROM deaths d
  JOIN vaccinations v
    USING (location, date)
  WHERE d.continent IS NOT NULL;
