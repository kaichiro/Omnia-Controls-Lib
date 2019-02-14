/* Instruções de unilização
* Modifique apenas os valores para as duas variáveis logo abaixo:
*  - @pUnidadeDescricao (parte ou todo da descrição da unidade/loja)
*  - @pDataTexto = data no padrão ano(4)-mês(2)-dia(2), ex.: 2020-12-31
* */

-- Primeiro valor de parâmetro a ser modificado
declare @pUnidadeDescricao varchar(64);
set @pUnidadeDescricao = 'co%gyn';

-- Segundo valor de parâmetro a ser modificado
declare @pDataTexto varchar(10);
set @pDataTexto = '2019-01-04';


use primeWARE;

set dateformat ymd;

declare @pIdUnidade uniqueidentifier;
set @pIdUnidade = (select top 1 und.ECO_ID from Unidade und where und.Descricao like @pUnidadeDescricao);

declare @pData datetime;
set @pData = @pDataTexto + ' 23:59:59';

--set @pData = CONVERT(VARCHAR(10), @pData, 102);

with dadosIniciais as
(
	select und.ECO_ID idUnidade, ime.ECO_ID idIME, ime.ProdutoFinal idPF, ime.TipoAtualizacaoEstoque
	from Unidade und 
	inner join CabecalhoMovimentoEstoque cme on und.ECO_ID = cme.Unidade
	inner join ItemMovimentoEstoque ime on cme.ECO_ID = ime.Cabecalho
	where und.ECO_ID = @pIdUnidade
	and cme.DataAtualizacaoEstoque >= @pData
	and cme.Cancelado = 0
	and cme.State like '%Processad%'
	and ime.AtualizaSaldoEstoque = 1
	and ime.TipoAtualizacaoEstoque in ('Saida', 'Entrada')
)
, SaldoAtual as
(
	select distinct sp.ProdutoFinal idPF, sp.Unidade idUnidade, coalesce(sp.Quantidade,0.0) SaldoAtual
	from SaldoProduto sp 
	where sp.Unidade = @pIdUnidade 
	and sp.Unidade is not null
	and sp.ProdutoFinal is not null
	and sp.Quantidade <> 0.0
	and sp.Periodo = '000000'
)
, qtdeInOut as
(
	select
	x.idPF, 
	x.idUnidade,
	(
		ime.Quantidade *
		case x.TipoAtualizacaoEstoque 
			when 'Saida' then 1
			when 'Entrada' then -1
			else 0.0 
		end 
	) Quantidade
	from dadosIniciais x
	inner join ItemMovimentoEstoque ime on x.idIME = ime.ECO_ID
)
, saldoDoDia as
(
	select * from qtdeInOut
	union all
	select * from SaldoAtual
)
select
sum(x.Quantidade) Quantidade, 
und.Descricao Unidade, 
--pf.CodigoBarras, 
--prd.Referencia, 
--prd.Descricao Produto,
@pData SaldoDoDia
from saldoDoDia x
inner join Unidade und on x.idUnidade = und.ECO_ID
--inner join ProdutoFinal pf on x.idPF = pf.ECO_ID
--inner join Produto prd on pf.Produto = prd.ECO_ID
group by 
und.Descricao--, 
--pf.CodigoBarras, 
--prd.Referencia, 
--prd.Descricao
--order by und.Descricao, prd.Descricao
