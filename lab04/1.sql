--create extension plpython3u;

create or replace function get_id_by_year(cur_year integer) 
    returns integer
    language plpython3u
as
$$
    if cur_year > 2016:
        return -1
    fin_id = plpy.execute(f"\
        select gs.idgame\n\
        from games gs\n\
        where gs.year = {cur_year};"
    )
    return fin_id[0]["idgame"]
$$;
