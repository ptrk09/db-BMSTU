--Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY и предложения HAVING.
SELECT id, COUNT(medal)
FROM medal
WHERE medal IS NOT NULL
GROUP BY id
HAVING COUNT(medal) > 2
ORDER BY id;