
-- Advanced Joins
-- https://www.hackerrank.com/domains/sql?filters%5Bsubdomains%5D%5B%5D=advanced-join&badge_type=sql

-- Exercise 1
-- SQL Project Planning

SET sql_mode = '';
SELECT Start_Date, End_Date
FROM 
    (SELECT Start_Date FROM Projects WHERE Start_Date NOT IN (SELECT End_Date FROM Projects)) a,
    (SELECT End_Date FROM Projects WHERE End_Date NOT IN (SELECT Start_Date FROM Projects)) b 
WHERE Start_Date < End_Date
GROUP BY Start_Date 
ORDER BY DATEDIFF(End_Date, Start_Date), Start_Date


-- Exercise 2
-- Placements

-- names of those students whose best friends got offered a higher salary than them
-- Names must be ordered by the salary amount offered to the best friends

SELECT s.name
FROM students s join friends f on s.id = f.id
    JOIN packages p1 on p1.id = s.id
    JOIN packages p2 on p2.id = f.friend_id
WHERE p1.salary < p2.salary
ORDER BY p2.salary


-- Exercise 3
-- Symmetric Pairs
SELECT f1.x, f1.y
FROM Functions f1, Functions f2
WHERE f1.x = f2.y and f1.y = f2.x
GROUP By f1.x, f1.y
HAVING count(f1.x) > 1 or f1.X<f1.Y
ORDER BY f1.x ASC, f1.y


-- Exercise 4
-- Interviews

-- contest_id, hacker_id, name, sum of total submissions,
-- total_accepted_submissions, total_view, total_unique_views
-- Excelute the contest if all four sums are 0
-- order by contest_id

SELECT con.contest_id
	,con.hacker_id
	,con.name
	,sum(total_submissions)
	,sum(total_accepted_submissions)
	,sum(total_views)
	,sum(total_unique_views)
FROM contests con
JOIN colleges col ON con.contest_id = col.contest_id
JOIN challenges cha ON col.college_id = cha.college_id
LEFT JOIN (
	SELECT challenge_id
		,sum(total_views) AS total_views
		,sum(total_unique_views) AS total_unique_views
	FROM view_stats
	GROUP BY challenge_id
	) vs ON cha.challenge_id = vs.challenge_id
LEFT JOIN (
	SELECT challenge_id
		,sum(total_submissions) AS total_submissions
		,sum(total_accepted_submissions) AS total_accepted_submissions
	FROM submission_stats
	GROUP BY challenge_id
	) ss ON cha.challenge_id = ss.challenge_id
GROUP BY con.contest_id
	,con.hacker_id
	,con.name
HAVING sum(total_submissions) != 0
	OR sum(total_accepted_submissions) != 0
	OR sum(total_views) != 0
	OR sum(total_unique_views) != 0
ORDER BY contest_id;


-- Exercise 5
-- 15 Days of learning SQL

SELECT submission_date
	,(
		SELECT COUNT(DISTINCT hacker_id)
		FROM Submissions s2
		WHERE s2.submission_date = s1.submission_date
			AND (
				SELECT COUNT(DISTINCT s3.submission_date)
				FROM Submissions s3
				WHERE s3.hacker_id = s2.hacker_id
					AND s3.submission_date < s1.submission_date
				) = dateDIFF(s1.submission_date, '2016-03-01')
		)
	,(
		SELECT hacker_id
		FROM submissions s2
		WHERE s2.submission_date = s1.submission_date
		GROUP BY hacker_id
		ORDER BY count(submission_id) DESC
			,hacker_id limit 1
		) AS shit
	,(
		SELECT name
		FROM hackers
		WHERE hacker_id = shit
		)
FROM (
	SELECT DISTINCT submission_date
	FROM submissions
	) s1
GROUP BY submission_date