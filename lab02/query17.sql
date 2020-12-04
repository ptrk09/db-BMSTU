--Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.
INSERT INTO games (idgame, city, year, season)
VALUES (37, 
        'New_city', 
        (
        SELECT SUM(age)
        FROM athletes
        WHERE age IS NOT NULL
        ), 
        'Winter');