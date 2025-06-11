select 
	l.loc_integrationid iflocal,
	ds.tsk_id id_tarefa,
	ds.hty_initialdatehour data_coleta,
	l.e_cnpj cnpj,
	l.e_can canal,
	l.lgp_description bandeira,
	l.loc_description loja,
	l.loc_street endereco,
	l.loc_neighborhood bairro,
	l.loc_city cidade,
	l.loc_state estado,
	ds.e_pbrfas disponivel,
	ds.e_ftbiscoito foto_biscoito,
	ds.e_ftpacote foto_pacote,
	ds.e_ftsacaria foto_sacaria,
	ds.e_ftsache foto_sache,
	null foto_pate,
	p.age_id id_interno,
	p.age_login,
	p.age_name promotor,
	p.e_posto posto_de_trabalho,
	p.tipo_pessoa,
	p.tea_description supervisor,
	l.loc_mail email_comercial
from
	brf_pet_2.f_dis_share_sort_as ds
	inner join brf_pet_2.d_locais l on l.loc_id = ds.loc_id
	inner join brf_pet_2.d_pessoas p on p.age_id = ds.age_id
where
	ds.hty_initialdatehour between '2025-06-06' and '2025-06-07'
	and ds.e_pbrfas = 'NÃO'
 	and ds.tsk_id not in ('625724059', '625724211', '625858461', '625858337', '625858363')
	
union all

select 
	l.loc_integrationid iflocal,
	ls.tsk_id id_tarefa,
	ls.hty_initialdatehour data_coleta,
	l.e_cnpj cnpj,
	l.e_can canal,
	l.lgp_description bandeira,
	l.loc_description loja,
	l.loc_street endereco,
	l.loc_neighborhood bairro,
	l.loc_city cidade,
	l.loc_state estado,
	ls.e_pbrfesp disponivel,
	ls.e_ftbiscoitoesp foto_biscoito,
	ls.e_ftpacoteesp foto_pacote,
	ls.e_ftsacariaesp foto_sacaria,
	ls.e_ftsacheesp foto_sache,
	ls.e_ftpateesp foto_pate,
	p.age_id id_interno,
	p.age_login,
	p.age_name promotor,
	p.e_posto posto_de_trabalho,
	p.tipo_pessoa,
	p.tea_description supervisor,
 	l.loc_mail email_comercial
from
	brf_pet_2.f_loja_ideal ls
	inner join brf_pet_2.d_locais l on l.loc_id = ls.loc_id
	inner join brf_pet_2.d_pessoas p on p.age_id = ls.age_id
where
	ls.hty_initialdatehour between '2025-06-06' and '2025-06-07'
	and ls.e_pbrfesp = 'NÃO'
