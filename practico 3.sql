USE world;

-- 1
SELECT city.NAME, country.Name, country.Region, country.GovernmentForm
FROM city 
INNER JOIN country ON city.CountryCode=country.Code
ORDER BY city.Population ASC
LIMIT 10;

-- 2
SELECT country.Name, city.Name, country.Population
FROM country
LEFT JOIN city ON country.Capital=city.ID
ORDER BY country.Population LIMIT 10;

-- 3
SELECT country.Name, country.Continent, countrylanguage.Language
FROM country
RIGHT JOIN countrylanguage ON country.Code=countrylanguage.CountryCode
WHERE countrylanguage.IsOfficial="T";

-- 4
SELECT country.Name, city.Name, country.SurfaceArea
FROM country
LEFT JOIN city ON country.Capital=city.ID
ORDER BY country.SurfaceArea DESC LIMIT 20;

-- 5
SELECT city.Name, countrylanguage.Language, countrylanguage.Percentage
FROM city
INNER JOIN countrylanguage ON city.CountryCode=countrylanguage.CountryCode
WHERE countrylanguage.IsOfficial='T'
ORDER BY city.Population;

-- 6
SELECT * FROM (
    (SELECT * FROM city
    ORDER BY Population
    LIMIT 10)
    UNION ALL
    (SELECT * FROM city
    ORDER BY Population DESC
    LIMIT 10)
) AS combined_results
ORDER BY Population;

-- 7
(SELECT countrylanguage.CountryCode, country.Name
FROM countrylanguage
LEFT JOIN country ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Language = "English"
AND countrylanguage.IsOfficial = "T")
INTERSECT
(SELECT countrylanguage.CountryCode, country.Name
FROM countrylanguage
LEFT JOIN country ON countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Language = "French"
AND countrylanguage.IsOfficial = "T") ;

-- 8
(SELECT countrylanguage.CountryCode, country.Name
FROM countrylanguage
LEFT JOIN country on countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Language = "English")
EXCEPT
(SELECT countrylanguage.CountryCode, country.Name
FROM countrylanguage
LEFT JOIN country on countrylanguage.CountryCode = country.Code
WHERE countrylanguage.Language = "Spanish");

-- parte 2
SELECT city.Name, country.Name
FROM city
INNER JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina';

SELECT city.Name, country.Name
FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Argentina';

/*
Si, devuelven los mismos valores.
Esto es debido a que ambas querys buscan el mismo resultado de forma diferentes
la primera query busca hacer un inner join donde matcheen los codigos y que el nombre del pais
sea argentina.
Mientras que en la segunda query busca todos paises con sus ciudades y luego a ese resultado lo
filtra por el nombre del pais
*/

SELECT city.Name, country.Name
FROM city
LEFT JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina';

SELECT city.Name, country.Name
FROM city
LEFT JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Argentina';

/* 
Al cambiar inner join por left join notamos un cambio en la primera query esto se da porque la query 
cambia su foco ahora trae a todas las ciudades y rellena en caso de que no sea el pais "Argentina" con
null, en la segunda no afecta porque el filtro se hace despues del join. 
*/