use primeWARE;

set dateformat ymd;

with Infos010 as (
	select
	cme.ECO_ID CabecalhoID
	, cme.Personalidade PersonalidadeID
	, ime.ECO_ID ItemMovEstoqueID
	, ime.Quantidade
	, ime.Serial
	, coalesce(ime.AgenteVenda, cme.AgenteVenda) AgenteVendaID
	, coalesce(ime.DataPrevistaEntrega, cme.DataEmissao) Data
	, prd.Descricao Produto
	, prd.TipoProduto
	from GrupoTipoMovEstoque gtme
	inner join TipoMovimentoEstoque tme on gtme.ECO_ID = tme.GrupoTipoMovEstoque
	inner join CabecalhoMovimentoEstoque cme on tme.ECO_ID = cme.TipoMovimentoEstoque
	inner join ItemMovimentoEstoque ime on cme.ECO_ID = ime.Cabecalho
	inner join ProdutoFinal pf on ime.ProdutoFinal = pf.ECO_ID
	inner join Produto prd on pf.Produto = prd.ECO_ID
	where gtme.Descricao = 'ORDEM DE SERVICO'
	and (
		cme.DataEmissao between @pDTIni and @pDTFim
		or 
		ime.DataPrevistaEntrega between @pDTIni and @pDTFim
	)
	and cme.Cancelado = 0
	and cme.QuantidadeQuitada = 0
	and cme.State = 'Processado'
	and ime.QuantidadeQuitada = 0
)
, Infos020 as (
	select
	x.CabecalhoID
	, x.PersonalidadeID
	, x.ItemMovEstoqueID
	, x.Quantidade
	, x.Serial
	, x.AgenteVendaID
	, x.Data
	, x.Produto PecaServico
	, x.TipoProduto
	, (
		select top 1 y.Produto from Infos010 y 
		where x.CabecalhoID = y.CabecalhoID 
		and x.Serial = y.Serial 
		and y.TipoProduto = 'ProdutoAcabado'
	) ProdutoCliente
	from Infos010 x
	where x.TipoProduto <> 'ProdutoAcabado'
	and x.AgenteVendaID = '{PTECNICO}'
	{varTecnicos} 
)
	select 
	1 flag
	, x.Quantidade
	, x.PecaServico
	, x.ProdutoCliente
	, x.Data
	, avPers.Nome Tecnico
	, pers.Nome Cliente
	from Infos020 x
	left join AgenteVenda av on x.AgenteVendaID = av.ECO_ID
	left join Personalidade avPers on av.Personalidade = avPers.ECO_ID
	left join Personalidade pers on x.PersonalidadeID = pers.ECO_ID

