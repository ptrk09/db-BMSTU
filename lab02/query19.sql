--Инструкция UPDATE со скалярным подзапросом в предложении SET.
UPDATE games
SET year = (
	SELECT SUM(age)
	FROM athletes
	WHERE age IS NOT NULL
)
WHERE idgame = 37;