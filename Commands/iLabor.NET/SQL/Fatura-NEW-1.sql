use iLabor;

set dateformat ymd;

declare @pDTIni datetime;
declare @pDTFim datetime;
declare @pConvenio int;

set @pDTIni = '2019-01-01';
set @pDTFim = GETDATE();
set @pConvenio = (select top 1 c.ECO_ID from Convenio c where c.Nome = 'AMIL');

with itens as (
	select
	pp.ECO_ID ProtocoloProcedimentoID
	, pp.Procedimento ProcedimentoID
	, pp.SituacaoColeta SituacaoColetaID
	, pp.Recepcionador RecepcionadorID
	, p.ECO_ID ProtocoloID
	, p.Paciente PacienteID
	, cp.Convenio ConvenioID
	, tpp.ECO_ID TabelaPrecoProcedimentoID
	from Protocolo_Procedimento pp
	inner join Convenio_Plano cp on pp.Convenio_Plano = cp.ECO_ID
	inner join Protocolo p on pp.Protocolo = p.ECO_ID
	left join Tabela_Preco_Procedimento tpp on cp.Tabela_Preco = tpp.Tabela_Preco and pp.Procedimento = tpp.Procedimento
	where pp.Data_Recepcao between @pDTIni and @pDTFim
	and pp.StateFatura = 'Aberto'
	and pp.Visivel_Fatura = 1
	and cp.Convenio = @pConvenio
)
select
pp.Data_Recepcao Data
, pp.Status
, pp.MotivoPendencia
, pp.Quantidade
, pp.ObservacaoFatura
, pp.Valor_Convenio
, p.Numero_Protocolo Protocolo
, pac.Nome Paciente
, prc.Descricao ProcedimentoDescricao
, case when replace(tpp.Codigo, ' ', '') <> '' then tpp.Codigo else prc.Codigo end ProcedimentoCodigo
, sc.Descricao SituacaoColeta
, recep.Nome Atendente
from itens x
inner join Protocolo_Procedimento pp on x.ProtocoloProcedimentoID = pp.ECO_ID
inner join Protocolo p on x.ProtocoloID = p.ECO_ID
left join Paciente pac on x.PacienteID = pac.ECO_ID
inner join Procedimento prc on x.ProcedimentoID = prc.ECO_ID
left join Tabela_Preco_Procedimento tpp on x.TabelaPrecoProcedimentoID = tpp.ECO_ID
left join SituacaoColeta sc on x.SituacaoColetaID = sc.ECO_ID
left join Usuario recep on x.RecepcionadorID = recep.ECO_ID;
