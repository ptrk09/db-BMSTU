--Инструкция SELECT, использующая вложенные коррелированные подзапросы в качестве производных таблиц в предложении FROM
--вывод ункальных строк с именем атлета, годом олимпиады, сезон и город 
SELECT DISTINCT athletes.name, dopInfo.year, dopInfo.season, dopInfo.city
FROM athletes JOIN (
	medal join games on medal.idgame = games.idgame
) AS dopInfo on athletes.id = dopInfo.id
ORDER BY dopInfo.year;