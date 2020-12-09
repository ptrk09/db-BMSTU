--получить _count строк из переданной таблицы
create function get_data_from_tabel(any_type anyelement, _count integer)
returns setof anyelement as
$$
begin
    return query
        execute format('
            select *
            from %s
            limit $1',
            pg_typeof(any_type)
        )
        using _count;
end;
$$
language plpgsql;