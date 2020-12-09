create or replace function get_avr_res(a integer, b integer)
    returns integer
    language plpython3u
as
$$
    return abs(a - b) // 2
$$;

create or replace aggregate get_avr_all_int(integer) (
	sfunc = get_avr_res,
	stype = integer,
	initcond = 0
);

select get_avr_all_int(year)
from games;
