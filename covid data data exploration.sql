
--view the tables
SELECT *
FROM Coviddeaths;

SELECT *
FROM CovidVaccinations;

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM Coviddeaths
ORDER BY 1,2

--change data type for total_deaths to float  
ALTER TABLE coviddeaths
ALTER COLUMN total_deaths FLOAT

--change data type for total_cases to float  
ALTER TABLE coviddeaths
ALTER COLUMN total_cases FLOAT


--total cases vs total deaths
--shows likelihood of death from covid in different countries(nigeria)

SELECT location, date, total_cases,  total_deaths, (total_deaths/total_cases)*100 AS deathPercentage
FROM Coviddeaths
WHERE LOCATION LIKE 'nige%a'
ORDER BY 1,2

--total cases vs population
--shows what percentage of the population got covid'

SELECT location, date, total_cases,  population, (total_cases/population)*100  AS PercentPopulationInfected
FROM Coviddeaths
ORDER BY 1,2

--looking at countries with highest infection rate
SELECT location, MAX(total_cases) as HighestInfectionCount,  population, MAX((total_cases/population)*100)  AS PercentPopulationInfected
FROM Coviddeaths
GROUP BY location,population 
ORDER BY 4 DESC

--countries with highest death count per population
SELECT location, MAX(total_deaths) AS HighestDeathCount,  population, MAX((total_deaths/population)*100)  AS PercentPopulationdeath
FROM Coviddeaths
WHERE continent IS NOT NULL
GROUP BY location,population 
ORDER BY 2 DESC

--death count by continent
SELECT continent, MAX(total_deaths) AS TotalDeathCount  
FROM Coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 2 DESC

--death count by continent
SELECT continent, MAX(total_deaths) AS TotalDeathCount,   MAX((total_deaths/population)*100)  AS PercentPopulationdeath
FROM Coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY 3 DESC

--global numbers
SELECT date, SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths
FROM Coviddeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2

--join deaths and vaccination table and check total population vs vaccinations
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(CONVERT(FLOAT, vac.new_vaccinations )) OVER (PARTITION BY dea.location order by dea.location, dea.date)
	AS RollingPeopleVaccinated
FROM Coviddeaths dea
JOIN CovidVaccinations vac
	ON dea.date = vac.date
	AND dea.location = vac.location
	WHERE dea.continent IS NOT NULL
	ORDER BY 2,3


 