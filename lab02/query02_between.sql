-- используем BETWEEN 
-- вывод номер олимпиады и город в котором она проходила с 2000 по 2010 год
SELECT idgame, city
FROM games
WHERE year BETWEEN 2000 AND 2010
