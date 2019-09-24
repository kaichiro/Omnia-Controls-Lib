use primeWARE;

set dateformat ymd;

declare @pDTIni datetime = '2019-01-01';

select
cme.DataEmissao as DataEmissaoCabecalhoMovimento
, und.Descricao as Unidade
, undMain.Descricao as UnidadeMain
, cce.CabecalhoMovimentoEstoque_O as OrdemCCE
, cce.DataHoraCorrecao
, cce.Texto as TextoCorrecao
, tme.Descricao as TipoMovimento
, cmen.Numero as  NumeroPadraoCabecalhoMovimento
from CabecalhoMovimentoEstoque as cme
inner join Unidade as und on cme.Unidade = und.ECO_ID
left join Unidade as undMain on und.UnidadeEstoque = undMain.ECO_ID
inner join CCe as cce on cme.ECO_ID = cce.CabecalhoMovimentoEstoque
inner join TipoMovimentoEstoque as tme on cme.TipoMovimentoEstoque = tme.ECO_ID
left join CabMovEstoqueNumero as cmen on cme.NumeroPadrao = cmen.ECO_ID
where cme.DataEmissao >= @pDTIni
and cme.Cancelado = 0
and cme.State = 'NFe Processada'
order by 
cme.DataEmissao desc
, cce.DataHoraCorrecao asc
;

