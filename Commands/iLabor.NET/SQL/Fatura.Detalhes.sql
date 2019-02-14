use iLabor;

set dateformat ymd;

declare @pDTIni datetime = '2018-01-01';
declare @pDTFim datetime = getdate();

with FaturaOnly as
(
	select 
	f.ECO_ID idFatura
	, c.ECO_ID idConvenio
	, pp.ECO_ID idProtocoloProcedimento
	, prc.ECO_ID idProcedimento
	, st.ECO_ID idSetor
	, p.ECO_ID idProtocolo
	, p.Paciente idPaciente
	from Fatura f
	inner join Convenio c on f.Convenio = c.ECO_ID
	inner join Fatura_Procedimento fp on f.ECO_ID = fp.Fatura
	inner join Protocolo_Procedimento pp on fp.Protocolo_Procedimento = pp.ECO_ID
	inner join Procedimento prc on pp.Procedimento = prc.ECO_ID
	left join Setor st on prc.Setor = st.ECO_ID
	inner join Protocolo p on pp.Protocolo = p.ECO_ID
	where f.Data_Teto between @pDTIni and @pDTFim
)
	select
	f.Numero_Fatura, f.Data_Teto,
	c.Nome Convenio,
	pp.Valor_Convenio, pp.Quantidade,
	prc.Descricao Procedimento,
	st.Descricao Setor,
	p.Numero_Protocolo, p.Data_Entrada,
	pac.Nome Paciente
	from FaturaOnly x
	inner join Fatura f on x.idFatura = f.ECO_ID
	inner join Convenio c on x.idConvenio = c.ECO_ID
	inner join Protocolo_Procedimento pp on x.idProtocoloProcedimento = pp.ECO_ID
	inner join Procedimento prc on x.idProcedimento = prc.ECO_ID
	left join Setor st on x.idSetor = st.ECO_ID
	inner join Protocolo p on x.idProtocolo = p.ECO_ID
	inner join Paciente pac on x.idPaciente = pac.ECO_ID
	