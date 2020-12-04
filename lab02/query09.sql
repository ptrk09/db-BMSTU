--Инструкция SELECT, использующая простое выражение CASE
--Вывод id участника, id олим. игры и юбилейная ли это олимпиада или нет
SELECT id, idgame,
	CASE idgame WHEN 10 THEN 'Юбилейная'
                WHEN 20 THEN 'Юбилейная'
                ELSE 'Не юбилейная'
	END as "10-20"
FROM medal;