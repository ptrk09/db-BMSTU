--Создание новой временной локальной таблицы из результирующего набора данных инструкции SELECT
SELECT id, name
INTO TEMP new_data
FROM athletes;