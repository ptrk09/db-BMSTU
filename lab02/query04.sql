--Инструкция SELECT, использующая предикат IN с вложенным подзапросом.
--Вывести имя, возраст и страну спортсменов, если название страны начинается на букву U
SELECT name, age, noc
FROM athletes
WHERE noc IN (
	SELECT noc
	FROM nation
	WHERE namecountry LIKE 'U%'
)
ORDER BY noc;