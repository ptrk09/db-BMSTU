create or replace function get_need_mans_by_age(need_age integer)
    returns table(
		name varchar,
		sex varchar
	)
    language plpython3u
as
$$
    temp_data = plpy.execute(f"\
        select *\n\
        from athletes\n\
        where age > '{need_age}';"
    )
    return [{"name": el["name"], "sex": el["sex"]} for el in temp_data]
$$;

select *
from get_need_mans_by_age(24);
