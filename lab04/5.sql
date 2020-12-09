drop trigger games_edit on games;

create or replace function inter_triger()
returns trigger
language plpython3u
as
$$
    tbn, twh = TD["table_name"], TD["when"]
    ev, sch = TD["event"], TD["table_schema"]	
    plpy.notice(
        f"Trigger function {twh} {ev} on table\
        {tbn} from schema {sch} is allowed adn work."
    )
    return None
$$;

create trigger games_edit
    before insert or delete
    on games
for each row
execute procedure inter_triger();

select * from games;

insert into games(idgame, city, year, season)
values (42, 'loll', 3000, 'Winter');


