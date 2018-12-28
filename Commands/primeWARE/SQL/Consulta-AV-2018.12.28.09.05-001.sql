use primeWARE;

set dateformat ymd;

declare @pDTIni datetime;
set @pDTIni = '2018-11-01';
declare @pDTFim datetime;
set @pDTFim = '2018-11-30 23:59:59';

with infos010 as
(
	select
		prd.ECO_ID idProduto
		, pf.ECO_ID idPF
		, cr.ECO_ID idCor
		, tm.ECO_ID idTamanho
		, ime.ECO_ID idIME
		, imev.ECO_ID idIMEV
		, und.ECO_ID idUnidade
		, avPers.ECO_ID idPersAV
	from Produto prd
		inner join ProdutoFinal pf on prd.ECO_ID = pf.Produto
		left join Cor cr on pf.Cor = cr.ECO_ID
		left join Tamanho tm on pf.Tamanho = tm.ECO_ID
		inner join ItemMovimentoEstoque ime on pf.ECO_ID = ime.ProdutoFinal
		left join ItemMovEstoqueValor imev on ime.TipoValorTotal = imev.ECO_ID
		inner join CabecalhoMovimentoEstoque cme on ime.Cabecalho = cme.ECO_ID
		inner join Unidade und on cme.Unidade = und.ECO_ID
		left join AgenteVenda av on cme.AgenteVenda = av.ECO_ID
		left join Personalidade avPers on av.Personalidade = avPers.ECO_ID
	where prd.Descricao like 'PRODUTOS BAZAR%'
		and ime.TipoAtualizacaoEstoque = 'Saida'
		and cme.DataEmissao between @pDTIni and @pDTFim
)
select
	prd.Referencia
	, prd.Descricao Produto
	, avPers.Nome AgenteVenda
	, und.Descricao Unidade
	, sum(ime.Quantidade) Quantidade
	, sum(coalesce(imev.Valor, 0.0)) Valor
from infos010 x
	inner join Produto prd on x.idProduto = prd.ECO_ID
	inner join ItemMovimentoEstoque ime on x.idIME = ime.ECO_ID
	left join ItemMovEstoqueValor imev on x.idIMEV = imev.ECO_ID
	left join Personalidade avPers on x.idPersAV = avPers.ECO_ID
	left join Unidade und on x.idUnidade = und.ECO_ID
group by
	prd.Referencia
	, prd.Descricao 
	, avPers.Nome 
	, und.Descricao
order by 
	avPers.Nome
	, prd.Descricao
	, und.Descricao
