create or replace procedure is_exist_name(need_name varchar)
    language plpython3u
as
$$
    temp_len = len(plpy.execute(f"\
        select name\n\
        from athletes\n\
        where name = '{need_name}';"
    ))

    if temp_len:
        plpy.notice(
            f"Name '{need_name}' is exist."
        )
        return
    plpy.notice(
        f"Name '{need_name}' is not exist."
    )
$$;

call is_exist_name('A Dijiang');


