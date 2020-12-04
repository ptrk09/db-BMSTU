--Инструкция SELECT, использующая поисковое выражение CASE.
--Вывод id участника, id олим. игры и страя ли это олимпиада или нет
SELECT id, idgame,
	CASE WHEN idgame > 10 THEN 'Недавняя' ELSE 'Старая'
	END as OldOrY
FROM medal;