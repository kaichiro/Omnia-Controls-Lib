/* Listando registros de Médicos repetidos */

use iLabor;

with MedicosRepetidos as (
	select 
	COUNT(md.ECO_ID) QuantidadeRepetidos
	, md.CRM
	, md.Nome
	, md.Sigla_Conselho
	, md.UF_Conselho
	from Medico md
	group by
	md.CRM
	, md.Nome
	, md.Sigla_Conselho
	, md.UF_Conselho
	having COUNT(md.ECO_ID) > 1
)
, infos010 as (
	select
	mr.QuantidadeRepetidos
	, mr.CRM
	, mr.Nome
	, mr.Sigla_Conselho
	, mr.UF_Conselho
	, md.ECO_ID MedicoID
	from MedicosRepetidos mr
	inner join Medico md 
	on mr.CRM = md.CRM
	and mr.Nome = md.Nome 
	and mr.Sigla_Conselho = md.Sigla_Conselho
	and mr.UF_Conselho = md.UF_Conselho
)
, infos020 as (
	select
	x.QuantidadeRepetidos
	, x.CRM
	, x.Nome
	, x.Sigla_Conselho
	, x.UF_Conselho
	, x.MedicoID
	, (select COUNT(p.ECO_ID) from Protocolo p where x.MedicoID = p.Medico) QuantidadeProtocolos
--	, (select COUNT(pp.ECO_ID) from Protocolo_Procedimento pp inner join Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppm on pp.ECO_ID = ppm.Protocolo_Procedimentos where x.MedicoID = ppm.Medicos) QuantidadeProtocolos
	from infos010 x
)
	select
	x.QuantidadeRepetidos
	, x.CRM
	, x.Nome
	, x.Sigla_Conselho
	, x.UF_Conselho
	, x.MedicoID
	, x.QuantidadeProtocolos
	from infos020 x
	where x.QuantidadeProtocolos between 1 and 15
	order by x.Nome, x.QuantidadeProtocolos desc;
