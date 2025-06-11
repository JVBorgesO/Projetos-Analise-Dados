SELECT
    v.tsk_scheduleinitialdatehour::date AS data_tarefa,
    p.age_login AS login,
    p.age_name AS promotor,
    p.tea_description AS equipe,
    l.loc_id,
    l.loc_description AS loja,
    CASE WHEN v.hora_checkin IS NOT NULL THEN 'ATENDIDA' ELSE 'NAO ATENDIDA' END AS status_visita
FROM
    brf_pet_2.f_visitas_novo v
INNER JOIN
    brf_pet_2.d_pessoas p ON p.age_id = v.age_id
INNER JOIN
    brf_pet_2.d_locais l ON l.loc_id = v.loc_id
WHERE
    v.tsk_scheduleinitialdatehour BETWEEN '2025-06-09' AND current_date
    AND p.age_id NOT IN ('1379854', '1379866')
    AND p.tea_description <> 'ÉDER MONTEIRO'
    AND (CASE WHEN v.hora_checkin IS NOT NULL THEN 'ATENDIDA' ELSE 'NAO ATENDIDA' END) = 'NAO ATENDIDA'
ORDER BY
    p.age_name,
    data_tarefa;