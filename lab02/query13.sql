--Инструкция SELECT, использующая вложенные подзапросы с уровнем вложенности 3.
--Получить страну и кол-во участников из неё во время зимних олимпиад.
SELECT noc, COUNT(name)
FROM athletes
WHERE id IN (
	SELECT id
	FROM athletes
	WHERE id IN (
		SELECT id
		FROM medal
		WHERE idgame IN (
			SELECT idgame
			FROM games
			WHERE season = 'Winter'
		)
	)
)
GROUP BY noc
ORDER BY COUNT(name);