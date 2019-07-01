use iLabor;

set dateformat ymd;

declare @pFatura int;

set @pFatura = (select top 1 f.ECO_ID from Fatura f);

with itens as (
	select
	f.ECO_ID FaturaID
	, pp.ECO_ID ProtocoloProcedimentoID
	, pp.Procedimento ProcedimentoID
	, pp.SituacaoColeta SituacaoColetaID
	, pp.Recepcionador RecepcionadorID
	, p.ECO_ID ProtocoloID
	, p.Paciente PacienteID
	, cp.Convenio ConvenioID
	, tpp.ECO_ID TabelaPrecoProcedimentoID
	from Fatura f
	inner join Fatura_Procedimento fp on f.ECO_ID = fp.Fatura
	inner join Protocolo_Procedimento pp on fp.Protocolo_Procedimento = pp.ECO_ID
	inner join Convenio_Plano cp on pp.Convenio_Plano = cp.ECO_ID
	inner join Protocolo p on pp.Protocolo = p.ECO_ID
	left join Tabela_Preco_Procedimento tpp on cp.Tabela_Preco = tpp.Tabela_Preco and pp.Procedimento = tpp.Procedimento
	where f.ECO_ID = @pFatura
	and pp.StateFatura = 'Faturado'
	and pp.Visivel_Fatura = 1
)
select
f.Numero_Fatura FaturaNumero
, f.Data_Emissao FaturaDataEmissao
, f.Data_Geracao FaturaDataGeracao
, f.Data_Teto FaturaDataTeto
, f.Data_Vencimento FaturaDataVencimento
, f.Nota_Fiscal FaturaNotaFiscal
, f.Observacao FaturaObservacao
, f.Perc_Descontos FaturaPercentualDescontos
, f.Valor_Acrescimos FaturaValorAcrescimos
, f.Valor_Descontos FaturaValorDescontos
, pp.Data_Recepcao DataProcedimentoRecepcao
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
inner join Fatura f on x.FaturaID = f.ECO_ID
inner join Protocolo_Procedimento pp on x.ProtocoloProcedimentoID = pp.ECO_ID
inner join Protocolo p on x.ProtocoloID = p.ECO_ID
left join Paciente pac on x.PacienteID = pac.ECO_ID
inner join Procedimento prc on x.ProcedimentoID = prc.ECO_ID
left join Tabela_Preco_Procedimento tpp on x.TabelaPrecoProcedimentoID = tpp.ECO_ID
left join SituacaoColeta sc on x.SituacaoColetaID = sc.ECO_ID
left join Usuario recep on x.RecepcionadorID = recep.ECO_ID;
