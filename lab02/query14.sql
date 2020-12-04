--Инструкция SELECT, консолидирующая данные с помощью предложения GROUP BY, но без предложения HAVING.
SELECT id, COUNT(medal)
FROM medal
WHERE medal IS NOT NULL
GROUP BY id
ORDER BY id;