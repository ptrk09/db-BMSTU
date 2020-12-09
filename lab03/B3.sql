--поместить в game_buffer первые _count игр

create or replace procedure curproc(_count integer)
language plpgsql as
$$
declare
	curs cursor for select idgame, city, year from games;
	temp_idgame integer;
	temp_city varchar;
	temp_year integer;
begin
	create table if not exists games_buffer(
		idgame integer, 
		city varchar, 
		year integer
	);

	open curs;
	for itercounter in 1.._count loop
		fetch curs into temp_idgame, temp_city, temp_year;
		insert into games_buffer
		values(temp_idgame, temp_city, temp_year);
	end loop;
end;
$$;

call curproc(10);
select * from games_buffer;