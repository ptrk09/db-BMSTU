-- создать скалярную функцию
-- найти спортсмена по месту в суммарном зачёте медалей

create function get_name_by_best_count_medal(need_count integer)
returns varchar as
$$
begin
	return (
		select name
		from athletes
		where athletes.id in (
			select best_athletes.id
			from (
				select row_number() over() as id, 
                       need_data.id_athlete, 
                       need_data.count_medal
				from (
					select id as id_athlete, count(medal) as count_medal
					from medal
					where medal is not null
					group by id
					order by count_medal desc
					limit need_count
				) as need_data
			) as best_athletes
			where best_athletes.id = need_count
		)
	);
end;
$$
language plpgsql;