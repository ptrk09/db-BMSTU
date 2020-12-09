--при insert в таблицу наций записывать новые значения в буффер

create table full_buf_nation(
    noc varchar, 
    namecountry varchar, 
    capital varchar, 
    population integer, 
    region varchar
);

create or replace function log_insert()
returns trigger
language plpgsql as
$$
begin
	insert into full_buf_nation(noc, namecountry, capital, population, region)
	values(NEW.noc, null, new.capital, new.population, old.region);
	return old;
end;
$$;

create trigger _insert before insert
on nation
for each row
execute procedure log_insert();

insert into nation(noc, namecountry, capital, population, region) 
values('ZZZ', 'lol', 'loltanburg', 1111111111, 'asi');
