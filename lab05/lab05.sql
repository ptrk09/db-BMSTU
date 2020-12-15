--1. Создать файл games.json

copy(
	select row_to_json(data) 
    from (
        select *
        from games
    ) data 
) to '/Users/ptrk/BMSTU/db-BMSTU/lab05/games.json';

-- 2. загрузка games.json в таблицу

create or replace procedure get_table_from_json()
language plpgsql as
$$
begin
	create table if not exists games_json(
		idgame integer,
		city varchar,
		year integer,
		season varchar
	);
	delete from games_json;
	
	create table if not exists games_tmp_json(
		game_info jsonb
	);
	delete from games_tmp_json;

    copy games_tmp_json
    from '/Users/ptrk/BMSTU/db-BMSTU/lab05/games.json';
	
	insert into games_json(idgame, city, year, season)
    select (game_info->'idgame')::integer as idgame,
        (game_info->'city')::varchar as city,
        (game_info->'year')::integer as year,
        (game_info->'season')::varchar as season
    from games_tmp_json;

    drop table games_tmp_json;
end;
$$;

call get_table_from_json();

select * from games_json;

-- 3. inser json in table

create table if not exists student_table(
    id_student integer not null,
    student_name json not null
);

insert into student_table
values(1, '{"name": "Dmitriy", "surname": "Kovalev"}'),
(2, '{"name": "Efim", "surname": "Sokolov"}'),
(3, '{"name": "Sarkisov", "surname": "Artem"}');

select * from student_table;

-- 4.1 

--drop function get_json_data();

create or replace function get_json_data()
returns table(game json, type text)
language plpgsql as
$$
begin
    create table if not exists pc_games(
        game_info json
    );
    delete from pc_games;

    copy pc_games
    from '/Users/ptrk/BMSTU/db-BMSTU/lab05/pc_game.json';

    return query(
        select game_info #> '{game_name}' as "game_name", json_typeof(game_info #> '{game_name}') AS "type"
        from pc_games
    );

    drop table pc_games;
end;
$$;

select * from get_json_data();

-- 4.2
create or replace function get_json_data_3st_el()
returns table(game_info json)
language plpgsql as
$$
begin
    create table if not exists pc_games(
        game_info json
    );
    delete from pc_games;

    copy pc_games
    from '/Users/ptrk/BMSTU/db-BMSTU/lab05/pc_game.json';

    return query(
        select gi.game_info #> '{info, developer}' as "developer"
        from pc_games as gi
    );

    drop table pc_games;
end;
$$;

select * from get_json_data_3st_el();

-- 4.3

create or replace procedure print_json_exist_data()
language plpgsql as
$$
declare
tmp text;
begin
	tmp = '';
    create table if not exists pc_games(
        game_info json
    );
    delete from pc_games;

    copy pc_games
    from '/Users/ptrk/BMSTU/db-BMSTU/lab05/pc_game.json';

    select gi.game_info #> '{game_name}' as "developer"
	into tmp
    from pc_games as gi;
	
	if tmp is null then raise notice 'Nothing found';
    else raise notice 'Result: %', tmp;
    end if;

    drop table pc_games;
end;
$$;


call print_json_exist_data();

-- 4.4

create or replace procedure update_json_data()
language plpgsql as
$$
begin
    create table if not exists pc_games(
        game_info json
    );
    delete from pc_games;

    copy pc_games
    from '/Users/ptrk/BMSTU/db-BMSTU/lab05/pc_game.json';

    update pc_games
	set game_info = '{"game_name":"assisns creed","info":{"mark": "8.3", "developer": "ubisoft monrial"}}';
	
	copy(
		select gi.game_info
		from pc_games as gi
	) to '/Users/ptrk/BMSTU/db-BMSTU/lab05/pc_game.json';

    drop table pc_games;
end;
$$;

call update_json_data();

-- 4.5

create or replace procedure split_json_data()
language plpgsql as
$$
declare
	tmp text;
begin
    create table if not exists pc_games(
        game_info jsonb
    );
    delete from pc_games;

    copy pc_games
    from '/Users/ptrk/BMSTU/db-BMSTU/lab05/pc_game.json';

    select jsonb_pretty(gi.game_info)
	into tmp
	from pc_games as gi;
	
	raise notice '%', tmp;
	
    drop table pc_games;
end;
$$;

call split_json_data();
