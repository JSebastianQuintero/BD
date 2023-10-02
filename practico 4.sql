USE world;

-- 1
SELECT city.Name AS ciudad, country.Name AS pais, country.Population
FROM city
LEFT JOIN country ON city.CountryCode = country.Code
WHERE country.Population < 10000;

-- 2
WITH poblacion_promedio (value) AS (
	SELECT AVG(country.Population)
    FROM country)
SELECT country.Name
FROM country
WHERE country.Population > poblacion_promedio.value