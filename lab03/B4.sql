--получить размер таблиц

create or replace procedure get_table_size() 
language plpgsql as
$$
declare 
	curs cursor for select table_name, size
	from (
		select table_name,
			   pg_relation_size(cast(table_name as varchar)) as size 
		from information_schema.tables
		where table_schema not in ('information_schema','pg_catalog')
		order by size desc
	) AS t;
    cur_row record;
begin
	open curs;
	loop
		fetch curs into cur_row;
		exit when not found;
		raise notice '{table : %} {size : %}', cur_row.table_name, cur_row.size;
	end loop;
	close curs;
end
$$;

call get_table_size();