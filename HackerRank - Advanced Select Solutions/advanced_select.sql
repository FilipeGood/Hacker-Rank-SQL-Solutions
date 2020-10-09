
-- ADVANCED SELECT

-- Exercise 1
-- Type of Triangle

SELECT CASE 
		WHEN A + B > C
			AND A + C > B
			AND B + C > A
			THEN CASE 
					WHEN A = B
						AND B = C
						THEN 'Equilateral'
					WHEN A = B
						OR B = C
						OR A = C
						THEN 'Isosceles'
					WHEN A != B
						OR B != C
						OR A != C
						THEN 'Scalene'
					END
		ELSE 'Not A Triangle'
		END
FROM TRIANGLES;


-- Exercise 2
-- The PADS


SELECT CONCAT (
		name
		,'('
		,substring(occupation, 1, 1)
		,')'
		)
FROM occupations
ORDER BY name ASC;

SELECT CONCAT (
		"There are total "
		,cast(count(*) AS CHAR)
		," "
		,lower(occupation)
		,"s."
		)
FROM occupations
GROUP BY occupation
ORDER BY count(*) ASC;

-- Exercise 3
-- Occupations

SET @r1=0, @r2=0, @r3 =0, @r4=0;
SELECT MIN(Doctor), MIN(Professor), MIN(Singer), MIN(Actor) FROM
(SELECT CASE Occupation WHEN 'Doctor' THEN @r1:=@r1+1
                       WHEN 'Professor' THEN @r2:=@r2+1
                       WHEN 'Singer' THEN @r3:=@r3+1
                       WHEN 'Actor' THEN @r4:=@r4+1 END
       AS RowLine,
       CASE WHEN Occupation = 'Doctor' THEN Name END AS Doctor,
       CASE WHEN Occupation = 'Professor' THEN Name END AS Professor,
       CASE WHEN Occupation = 'Singer' THEN Name END AS Singer,
       CASE WHEN Occupation = 'Actor' THEN Name END AS Actor
       FROM OCCUPATIONS ORDER BY Name) AS t
GROUP BY RowLine;

-- Exercise 4
-- Binary Tree Nodes


SELECT n
	,CASE 
		WHEN p IS NULL
			THEN 'Root'
		WHEN (
				SELECT p
				FROM bst
				WHERE p = b.n limit 1
				) IS NOT NULL
			THEN 'Inner'
		ELSE 'Leaf'
		END
FROM bst b
ORDER BY n

-- Exercise 5
-- New Companies

SELECT DISTINCT c.company_code
	,c.founder
	,(
		SELECT count(DISTINCT lead_manager_code)
		FROM lead_manager
		WHERE company_code = c.company_code
		)
	,(
		SELECT count(DISTINCT senior_manager_code)
		FROM Senior_Manager
		WHERE company_code = c.company_code
		)
	,(
		SELECT count(DISTINCT manager_code)
		FROM Manager
		WHERE company_code = c.company_code
		)
	,(
		SELECT count(DISTINCT employee_code)
		FROM Employee
		WHERE company_code = c.company_code
		)
FROM company c
ORDER BY c.company_code