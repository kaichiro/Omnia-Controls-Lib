use iLabor;

select 1 Origem, 'Todos os Médicos' Tipo, COUNT(md.ECO_ID) Quantidade from Medico md
union all
select 0, 'Sem Protocolo e sem Protocolo_Procedimento', COUNT(md.ECO_ID)
from Medico md
where
not exists (select p.ECO_ID from Protocolo p where md.ECO_ID = p.Medico)
and
not exists (
	select ppm.ECO_ID from Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppm 
	where md.ECO_ID = ppm.Medicos
)
