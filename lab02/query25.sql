SELECT *
FROM (
	SELECT hm.name, hm.event, ROW_NUMBER() OVER (PARTITION BY hm.event) AS counter
	FROM medal JOIN (
		SELECT *, medal.id AS new_id
		FROM athletes JOIN medal ON athletes.id = medal.id
	) AS hm ON medal.id = hm.new_id
) AS new_table
WHERE counter = 1