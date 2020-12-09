create type info_comp as (id integer, name varchar, count_medal integer);

create or replace function get_comp_info_for_athl(athl_id integer)
returns info_comp
language plpython3u
as
$$
    need_name, need_id, need_count = "", 0, 0
    data_temp = plpy.execute(f"\
            select name\n\
            from athletes\n\
            where id = '{athl_id}';"
    )
    if not len(data_temp):
        return (need_id, need_name, need_count)

    need_name, need_id = data_temp[0]["name"], athl_id
    data_temp = plpy.execute(f"\
            select id, count(medal) as cou\n\
            from medal\n\
            where medal is not NULL\n\
            group by id;"
    )
    for el in data_temp:
        if el["id"] == athl_id:
            need_count = el["cou"]
            breake
    return (need_id, need_name, need_count)	
$$;

select * from get_comp_info_for_athl(24);
