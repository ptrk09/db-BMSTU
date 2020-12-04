--Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.
DELETE FROM games
WHERE idgame IN (
	SELECT g1.idgame
	FROM games g1
	WHERE g1.idgame > 35
);