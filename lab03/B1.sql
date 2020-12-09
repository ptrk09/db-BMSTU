--обновить значение age у атлетов возраст которых = [target_l; target_h]

--drop table athletes_copy;

select *
into temp athletes_copy
from athletes;

create or replace procedure update_age(new_age integer, target_l integer, target_h integer) 
as
$$
begin
	update athletes_copy
	set age = new_age
	where age between target_l and target_h;
end;
$$
language plpgsql;