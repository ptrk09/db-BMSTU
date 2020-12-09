-- получить кто кого выиграл

--drop table dop_data;

CREATE TABLE dop_data (
    id int not null primary key, 
    best_id int references athletes(id),  
    bad_id int references athletes(id)  
);

INSERT INTO dop_data 
(id, best_id, bad_id) 
VALUES 
(1, 1, 2),
(2, 2, 5),
(3, 3, 1),
(4, 4, 7),
(5, 5, 4),
(6, 6, 2),
(7, 7, null),
(8, 8, null),
(9, 9, null);

--drop function get_compet(need_id integer);

create function get_compet(need_id integer)
returns table(be_id integer, ba_id integer) as
$$
begin
return query (
	WITH RECURSIVE RecursiveOvertaking(best, bad) AS (
		SELECT best_id, bad_id
   		FROM dop_data
	    WHERE best_id = need_id
		
   		UNION
   		SELECT dop_data.best_id, dop_data.bad_id
   		FROM dop_data
      	JOIN RecursiveOvertaking r ON dop_data.best_id = r.bad
	)
	SELECT rec.best::integer,
		   rec.bad::integer
	FROM RecursiveOvertaking as rec
);
end;
$$
language plpgsql;