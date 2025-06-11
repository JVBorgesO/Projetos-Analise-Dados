select
    p.tea_description as equipe,
    sum(sub.total_lojas_planejadas) as total_lojas_planejadas,
    sum(sub.total_lojas_atendidas) as total_lojas_atendidas,
    round(
        (sum(sub.total_lojas_atendidas)::decimal / nullif(sum(sub.total_lojas_planejadas), 0)) * 100,
        2
    ) as produtividade_percentual
from
    brf_pet_2.f_visitas_novo v
    inner join brf_pet_2.d_pessoas p on p.age_id = v.age_id
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
group by
    p.tea_description
order by
    p.tea_description;
