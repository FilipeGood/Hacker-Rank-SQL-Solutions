

-- Aggregations

-- Exercise 1
-- Revising Aggregations - The Count Function
SELECT COUNT(*)
FROM city
WHERE population > 100000

-- Exercise 2
-- Revising Aggregations - The sum function

SELECT sum(population)
FROM city
WHERE district = 'California'

-- Exercise 3
-- Revising Aggregations - Averages

SELECT avg(population)
FROM city
WHERE district = 'California'

-- Exercise 4
-- Average Population

SELECT FLOOR(avg(population))
FROM city

-- Exercise 5
-- Japan Population

SELECT sum(population)
FROM city
WHERE COUNTRYCODE = 'JPN'

-- Exercise 6
-- Population Density Difference

SELECT max(population)-min(population)
FROM city

-- Exercise 7
-- The blunder

SELECT CEIL(AVG(Salary) - AVG(REPLACE(Salary, '0', '')))
FROM EMPLOYEES;

-- Exercise 8
-- Top Earners

SELECT (salary * months) AS earnings
    ,count(*)
FROM employee
GROUP BY earnings
ORDER BY earnings DESC limit 1;

-- Exercise 9
-- Weather Observation Station 2
-- Rounded to a scale of 2 decimal places
SELECT ROUND(sum(lat_n), 2), ROUND(sum(long_w), 2)
FROM Station

-- Exercise 10
-- Weather Obersation Station 13
SELECT ROUND(sum(lat_n), 4)
FROM Station
WHERE lat_n > 38.7880 and lat_n < 137.2345

-- Exercise 11
-- Weather Observation Station 14
SELECT ROUND(max(lat_n),4)
FROM Station
WHERE lat_n < 137.2345

-- Exercise 12
-- Weather Observation Station 15

SELECT ROUND(long_w,4)
FROM Station
WHERE lat_n < 137.2345
ORDER by lat_n DESC
limit 1;

-- OR

SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (
		SELECT MAX(LAT_N)
		FROM STATION
		WHERE LAT_N < 137.2345
		);

-- Exercise 13
-- Weather Observation Station 16

SELECT round(min(lat_n), 4)
FROM STATION
WHERE lat_n > 38.7780

-- Exercise 14
-- Weather Observation Station 17

SELECT ROUND(long_w,4)
FROM Station
WHERE lat_n > 38.7780
ORDER by lat_n ASC
limit 1;


-- Exercise 15
-- Weather Observation Station 18

SELECT ROUND(abs(min(lat_n) - max(lat_n)) + abs(min(long_w) - max(long_w)),4)
FROM Station

-- Exercise 16
-- Weather Observation Station 19
a = min(lat_n)
b = max(lat_n)
c = min(long_w)
d = max(long_w)

SELECT
    ROUND(SQRT(
        POWER(MAX(LAT_N)  - MIN(LAT_N),  2)
      + POWER(MAX(LONG_W) - MIN(LONG_W), 2)
    ), 4)
FROM 
    STATION;

-- Exercise 17
-- Weather Observation Station 20

SELECT round(s.lat_n, 4)
FROM station s
WHERE (
		SELECT ceil(count(s.lat_n) / 2)
		FROM station
		) = (
		SELECT count(s.lat_n)
		FROM station s1
		WHERE s1.lat_n >= s.lat_n
		)