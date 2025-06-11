select
    distinct v.tsk_scheduleinitialdatehour as data_tarefa,
    p.age_login as login,
    p.age_name as promotor,
    p.tea_description as equipe,
    sub.total_lojas_planejadas,
    sub.total_lojas_atendidas,
    (sub.total_lojas_atendidas::decimal / nullif(sub.total_lojas_planejadas, 0)) * 100 as produtividade
from
    brf_pet_2.f_visitas_novo v
    inner join brf_pet_2.d_pessoas p on p.age_id = v.age_id
    inner join brf_pet_2.d_locais l on l.loc_id = v.loc_id
    inner join (
        select
            age_id,
            tsk_scheduleinitialdatehour::date as data,
            count(distinct loc_id) as total_lojas_planejadas,
            count(distinct case when hora_checkin is not null then loc_id end) as total_lojas_atendidas
        from brf_pet_2.f_visitas_novo
        where tsk_scheduleinitialdatehour between '2025-06-01' and current_date
        group by age_id, tsk_scheduleinitialdatehour::date
    ) sub
        on sub.age_id = v.age_id
       and sub.data = v.tsk_scheduleinitialdatehour::date
where
    v.tsk_scheduleinitialdatehour between '2025-06-01' and current_date
    and p.age_id not in ('1379854', '1379866')
    and p.tea_description <> 'ÉDER MONTEIRO'
	-- and p.tea_description = 'FELIPE LEAL GONCALVES'
group by
    v.tsk_scheduleinitialdatehour,
    p.age_login,
    p.age_name,
    p.tea_description,
    v.data_check_in,
    v.data_check_out,
    sub.total_lojas_planejadas,
    sub.total_lojas_atendidas
order by
    p.age_name asc;
