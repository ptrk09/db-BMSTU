--Инструкция SELECT, использующая агрегатные функции в выражениях столбцов
--Вывести суммарное кол-во медалей в олимпийских играх 2014 и 2016 годов.
SELECT COUNT(*)
FROM athletes a JOIN medal m ON a.id = m.id
WHERE m.medal IS NOT NULL AND m.idgame IN (
	SELECT idgame
	FROM games
	WHERE year BETWEEN 2014 AND 2016
);