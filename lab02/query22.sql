WITH person_medal(id, count_medal) AS (
	SELECT id, COUNT(medal)
	FROM medal
	WHERE medal IS NOT NULL
	GROUP BY id
	ORDER BY id
)
SELECT COUNT(*)
FROM person_medal