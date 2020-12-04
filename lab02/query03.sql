--Инструкция SELECT, использующая предикат LIKE
--Вывести имяб возраст и страну спортсменов, чьё имя John
SELECT name, age, noc
FROM athletes
WHERE name LIKE '%John%';