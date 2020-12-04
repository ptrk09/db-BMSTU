--Инструкция SELECT, использующая предикат EXISTS с вложенным подзапросом
--Вывести имя, возраст и страну спортсменов, которые участвовали с олимпиады 1912 года
SELECT a.name, a.age, a.noc
FROM athletes as a
WHERE 
	EXISTS(
		SELECT m.id
		FROM medal as m
		WHERE m.idgame > 5 AND a.id = m.id
	);