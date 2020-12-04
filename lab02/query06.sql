--Инструкция SELECT, использующая предикат сравнения с квантором
--Вывести имя, возраст и страну спортсменов, возраст которых превышает средний
SELECT a1.name, a1.age, a1.noc
FROM athletes as a1
WHERE a1.age > ALL(
	SELECT AVG(age)
	FROM athletes
	WHERE age IS NOT NULL
);