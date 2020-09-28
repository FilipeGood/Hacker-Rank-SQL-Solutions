	

-- Exercise 11
-- Select cities that start with a vowel

SELECT DISTINCT city
FROM STATION
WHERE (city LIKE 'a%')
	OR (city LIKE 'e%')
	OR (city LIKE 'i%')
	OR (city LIKE 'o%')
	OR (city LIKE 'u%');
    
SELECT DISTINCT city
FROM STATION
WHERE city REGEXP "^[aeiou].*";

--- Exercise 12
-- Select cities that end with a vowel



SELECT DISTINCT city
FROM STATION
WHERE (city LIKE '%a')
	OR (city LIKE '%e')
	OR (city LIKE '%i')
	OR (city LIKE '%o')
	OR (city LIKE '%u');


-- Exercise 13
-- Select cities that start and end with a vowel
-- Using REGEX would be a much better solution....
SELECT DISTINCT city
FROM STATION
WHERE (
		(city LIKE '%a')
		OR (city LIKE '%e')
		OR (city LIKE '%i')
		OR (city LIKE '%o')
		OR (city LIKE '%u')
		)
	AND (
		(city LIKE 'a%')
		OR (city LIKE 'e%')
		OR (city LIKE 'i%')
		OR (city LIKE 'o%')
		OR (city LIKE 'u%')
		);

-- Exercise 14
-- Select cities that do not start with vowels

SELECT DISTINCT city
FROM STATION
WHERE (city NOT LIKE 'a%')
	AND (city NOT LIKE 'e%')
	AND (city NOT LIKE 'i%')
	AND (city NOT LIKE 'o%')
	AND (city NOT LIKE 'u%');
    

-- Exercise 15
-- Select cities that do not end with vowels

SELECT DISTINCT city
FROM STATION
WHERE (city NOT LIKE '%a')
	AND (city NOT LIKE '%e')
	AND (city NOT LIKE '%i')
	AND (city NOT LIKE '%o')
	AND (city NOT LIKE '%u');


-- Exercise 16
-- Query the list of CITY names from STATION that either do not start with vowels OR do not end with vowels. 

SELECT DISTINCT city
FROM STATION
WHERE (
		(city NOT LIKE '%a')
		AND (city NOT LIKE '%e')
		AND (city NOT LIKE '%i')
		AND (city NOT LIKE '%o')
		AND (city NOT LIKE '%u')
		)
	or (
		(city NOT LIKE 'a%')
		AND (city NOT LIKE 'e%')
		AND (city NOT LIKE 'i%')
		AND (city NOT LIKE 'o%')
		AND (city NOT LIKE 'u%')
		);

-- Exercise 17
-- Query the list of CITY names from STATION that either do not start with vowels AND do not end with vowels. 
SELECT DISTINCT city
FROM STATION
WHERE (
        (city NOT LIKE '%a')
        AND (city NOT LIKE '%e')
        AND (city NOT LIKE '%i')
        AND (city NOT LIKE '%o')
        AND (city NOT LIKE '%u')
        )
    AND (
        (city NOT LIKE 'a%')
        AND (city NOT LIKE 'e%')
        AND (city NOT LIKE 'i%')
        AND (city NOT LIKE 'o%')
        AND (city NOT LIKE 'u%')
        );

-- Exercise 18
--Query the Name of any student in STUDENTS who scored higher than  Marks. Order your output by the last three characters of each name. 
-- RIGHT(string, n ) => exctracts n characters from a string (starting from the right)

SELECT name
FROM STUDENTS
WHERE marks > 75
ORDER BY RIGHT(Name, 3)
	,id ASC

-- Exercise 19
--Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name
FROM employee
ORDER BY name

-- Exercise 20
--Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than 2000  per month who have been employees for less than 10 months. Sort your result by ascending employee_id.