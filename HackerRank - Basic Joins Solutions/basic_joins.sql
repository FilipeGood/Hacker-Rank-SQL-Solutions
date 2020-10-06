-- Basic Joins
-- url = https://www.hackerrank.com/domains/sql?filters%5Bsubdomains%5D%5B%5D=join

-- Exercise 1
--Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.

SELECT cit.name
FROM country co
	,city cit
WHERE cit.countrycode = co.code
	AND co.continent = 'Africa'

-- WITH JOIN

SELECT cit.name
FROM city cit
INNER JOIN country cot ON cit.countrycode = cot.code
WHERE cot.continent = 'Africa'


-- Exercise 2
--Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.



select sum(ci.population)
from country c left join city ci ON c.code = ci.countrycode
WHERE CONTINENT = 'Asia'


-- Exercise 3
-- Average Population of Each Continent


--- Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.

SELECT c.continent
    ,FLOOR(AVG(ci.POPULATION))
FROM city ci
 JOIN country c ON ci.COUNTRYCODE = c.CODE
GROUP BY c.continent


-- Exercise 4
-- The Report

SELECT CASE 
		WHEN g.grade < 8
			THEN NULL
		ELSE s.name
		END AS Name
	,g.grade
	,s.marks
FROM Students s
INNER JOIN Grades g ON s.marks BETWEEN g.min_mark
		AND g.max_mark
ORDER BY g.grade DESC
	,s.Name ASC
	,s.Marks ASC;

-- Exercise 5
-- The Competitors

SELECT h.hacker_id
	,h.name
FROM submissions s
JOIN challenges c ON s.challenge_id = c.challenge_id
JOIN difficulty d ON c.difficulty_level = d.difficulty_level
JOIN hackers h ON s.hacker_id = h.hacker_id
WHERE s.score = d.score
	AND c.difficulty_level = d.difficulty_level
GROUP BY h.hacker_id
	,h.name
HAVING COUNT(s.hacker_id) > 1
ORDER BY COUNT(s.hacker_id) DESC
	,s.hacker_id ASC


-- Exercise 6
-- Ollivanders Inventory
-- First  we need to get minimum coins_needed for wands with same age and power AS m
-- then we have to join with Wands and Wands_Property in order to get the id and age


SELECT id
    ,age
    ,m.coins_needed
    ,m.power
FROM (
    SELECT code
        ,power
        ,MIN(coins_needed) AS coins_needed
    FROM Wands
    GROUP BY code
        ,power
    ) AS m
JOIN Wands AS w ON m.code = w.code
    AND m.power = w.power
    AND m.coins_needed = w.coins_needed
JOIN Wands_Property AS p ON m.code = p.code
WHERE p.is_evil = 0
ORDER BY m.power DESC, age DESC;


-- Exercise 7
-- Challenges
SELECT c.hacker_id
	,h.name
	,count(c.hacker_id) AS c_count
FROM Hackers AS h
INNER JOIN Challenges AS c ON c.hacker_id = h.hacker_id
GROUP BY c.hacker_id
	,h.name
HAVING c_count = (
		SELECT MAX(temp1.cnt)
		FROM (
			SELECT COUNT(hacker_id) AS cnt
			FROM Challenges
			GROUP BY hacker_id
			ORDER BY hacker_id
			) temp1
		)
	OR c_count IN (
		SELECT t.cnt
		FROM (
			SELECT count(*) AS cnt
			FROM challenges
			GROUP BY hacker_id
			) t
		GROUP BY t.cnt
		HAVING count(t.cnt) = 1
		)
ORDER BY c_count DESC
	,c.hacker_id;



-- Exercise 8
-- Contest Leaderboard

-- The total score of a hacker is the sum of their maximum scores for all of the challenges. 
--  hacker_id, name, and total score of the hackers ordered by the descending score. 
-- then sort the result by ascending hacker_id
-- Exclude all hackers with a total score of  from your result.
SELECT h.hacker_id
	,h.name
	,sum(max_score.score) AS sum_scores
FROM Hackers h
INNER JOIN (
	SELECT hacker_id
		,max(score) AS score
	FROM submissions
	GROUP BY challenge_id
		,hacker_id
	) max_score ON h.hacker_id = max_score.hacker_id
GROUP BY h.hacker_id
	,h.name
HAVING sum_scores > 0
ORDER BY sum_scores DESC
	,hacker_id