--сравнить данные о спортсмене со средними значениями
create function compar_avr_params()
returns table(
	id integer, 
	name varchar, 
	age integer, 
	avg_age integer,
	height integer,
	avg_height integer,
	weight numeric(4, 1),
	avg_weight numeric(4, 1)
) as
$$
declare
	var_avg_age integer;
	var_avg_height integer;
	var_avg_weight numeric(4, 1);
begin
	select avg(a1.age)
	into var_avg_age
	from athletes as a1
	where a1.age is not null;
	
	select avg(a2.height)
	into var_avg_height
	from athletes as a2
	where a2.height is not null;
	
	select avg(a3.weight)
	into var_avg_weight
	from athletes as a3
	where a3.weight is not null;
	
	return query (
		select a.id, a.name, 
			   a.age, var_avg_age, 
		       a.height, var_avg_height, 
		       a.weight, var_avg_weight 
		from athletes as a
	);
end;
$$
language plpgsql;
