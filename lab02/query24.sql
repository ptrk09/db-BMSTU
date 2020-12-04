SELECT name, age, sport,
	MIN(age) OVER(PARTITION BY sport) AS min_age,
	AVG(age) OVER(PARTITION BY sport) AS min_age,
	MAX(age) OVER(PARTITION BY sport) AS max_age
FROM athletes