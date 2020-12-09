--при update страны помещать старые и новые значения в буффер

create table nation_bufffer (
   noc varchar,
   namecountry_old varchar,
   namecountry_new varchar
);
   
create or replace function log_update()
returns trigger
language plpgsql as
$$
begin
	if new.namecountry <> old.namecountry then
		insert into nation_bufffer (noc, namecountry_old, namecountry_new)
		values (old.noc, old.namecountry, new.namecountry);
	END IF;
	RETURN NEW;
end;
$$;

create trigger namecountry_update after update
on nation
for each row
execute procedure log_update();

UPDATE nation
SET namecountry = 'afghan'
WHERE namecountry = 'afghanistan';

select * from nation
where namecountry = 'afghan';