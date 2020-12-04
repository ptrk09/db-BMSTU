--Инструкция SELECT, использующая скалярные подзапросы в выражениях столбцов.
--Вывести страну и количество спортсменов за всё время из этой страны.
SELECT n.noc,
	   (
		   SELECT COUNT(*)
		   FROM athletes a
		   WHERE a.noc = n.noc
	   )
FROM nation as n;