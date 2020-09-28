-- Problem 1

SELECT *
from city
where population > 100000 and countrycode = 'USA'

-- Problem 2
SELECT name
from city
where population > 120000 and countrycode = 'USA'

-- Problem 3

SELECT *
FROM city

-- Problem 4
SELECT *
FROM city
WHERE id = 1661

-- Problem 5
SELECT *
FROM city
WHERE countrycode = 'JPN'

-- Problem 6
SELECT name
FROM city
WHERE countrycode = 'JPN';

-- Problem 7
Select CITY, STATE from STATION ORDER BY CITY, STATE;

-- Problem 8
SELECT DISTINCT city
FROM STATION
WHERE ID % 2 = 0;

-- Problem 9
SELECT (count(city)- count(distinct city))
from station

-- Problem 10
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY), CITY LIMIT 1;
SELECT CITY, LENGTH(CITY) FROM STATION ORDER BY LENGTH(CITY) DESC, CITY LIMIT 1;
