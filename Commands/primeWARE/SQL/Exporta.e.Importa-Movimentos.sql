/* Padrão para Date */
set dateformat ymd;

declare @p_data_ini datetime = '2019-02-15';

/* Base de Dados com informações a serem exportadas */
use primeWARE_MrBrook

declare @p_tme_id uniqueidentifier = (select top 1 tme.ECO_ID from TipoMovimentoEstoque tme where tme.Descricao = 'NFC-E');
declare @p_und_id uniqueidentifier = (select top 1 und.ECO_ID from Unidade und where und.Descricao = 'Mr. Brook Gyn Shop');

/* Tabela temporária para guardar os ECO_ID's dos cabecalhos a serem exportados */
create table #CMEs (ECO_ID uniqueidentifier);

/* Populando tabela temporária dos ECO_ID's dos cabecalhos a serem exportados */
insert into #CMEs
	select cme.ECO_ID from CabecalhoMovimentoEstoque cme
	where cme.DataEmissao >= @p_data_ini and cme.Unidade = @p_und_id and cme.TipoMovimentoEstoque = @p_tme_id
	order by cme.DataEmissao asc;

/* /// BEGIND - Sessão que cria tabelas temporárias \\\ */
CREATE TABLE #CME (
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[AgenteVenda] [uniqueidentifier] NULL,
	[AntecipacaoTributaria] [varchar](25) NULL,
	[CaixaRegistradora] [uniqueidentifier] NULL,
	[Cancelado] [bit] NULL,
	[CFOP] [varchar](5) NULL,
	[DataAtualizacaoEstoque] [datetime] NOT NULL,
	[DataDigitacao] [datetime] NULL,
	[DataEmissao] [datetime] NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[EnderecoCobranca] [uniqueidentifier] NULL,
	[EnderecoEntrega] [uniqueidentifier] NULL,
	[FormaParcelamento] [uniqueidentifier] NULL,
	[Gerente] [uniqueidentifier] NULL,
	[ModeloDocFiscal] [varchar](2) NOT NULL,
	[MovimentoFinanceiroHeader] [uniqueidentifier] NULL,
	[MovimentoTitular] [uniqueidentifier] NULL,
	[NumeroCOO] [int] NOT NULL,
	[Personalidade] [uniqueidentifier] NULL,
	[QuantidadeQuitada] [bit] NOT NULL,
	[SerieSubSerieNF] [varchar](5) NOT NULL,
	[SituacaoDocFiscal] [varchar](25) NOT NULL,
	[State] [varchar](30) NOT NULL,
	[TabelaPreco] [uniqueidentifier] NULL,
	[TipoMovimentoEstoque] [uniqueidentifier] NULL,
	[TipoTributacao] [uniqueidentifier] NULL,
	[TipoValorTotalBaseCOFINS] [uniqueidentifier] NULL,
	[TipoValorTotalBaseCOFINSST] [uniqueidentifier] NULL,
	[TipoValorTotalBaseICMS] [uniqueidentifier] NULL,
	[TipoValorTotalBaseICMSST] [uniqueidentifier] NULL,
	[TipoValorTotalBaseIPI] [uniqueidentifier] NULL,
	[TipoValorTotalBasePIS] [uniqueidentifier] NULL,
	[TipoValorTotalBasePISST] [uniqueidentifier] NULL,
	[TipoValorTotalCOFINS] [uniqueidentifier] NULL,
	[TipoValorTotalCOFINSST] [uniqueidentifier] NULL,
	[TipoValorTotalDescontos] [uniqueidentifier] NULL,
	[TipoValorTotalFrete] [uniqueidentifier] NULL,
	[TipoValorTotalICMS] [uniqueidentifier] NULL,
	[TipoValorTotalICMSST] [uniqueidentifier] NULL,
	[TipoValorTotalIPI] [uniqueidentifier] NULL,
	[TipoValorTotalNF] [uniqueidentifier] NULL,
	[TipoValorTotalOutros] [uniqueidentifier] NULL,
	[TipoValorTotalPIS] [uniqueidentifier] NULL,
	[TipoValorTotalPISST] [uniqueidentifier] NULL,
	[TipoValorTotalProduto] [uniqueidentifier] NULL,
	[TipoValorTotalSeguro] [uniqueidentifier] NULL,
	[Tributo] [uniqueidentifier] NULL,
	[Unidade] [uniqueidentifier] NULL,
	[UnidadeDestino] [uniqueidentifier] NULL,
	[RegimeTributario] [varchar](25) NULL,
	[FinalidadeEmissao] [varchar](15) NULL,
	[DataContingencia] [datetime] NULL,
	[TipoEmissaoNFe] [varchar](6) NULL,
	[JustificativaContingencia] [varchar](255) NULL,
	[IESubstitutoTributario] [varchar](30) NULL,
	[TipoOperacao] [varchar](8) NULL,
	[VersaoProcessadorNFe] [varchar](20) NULL,
	[FormatoImpressaoNFe] [varchar](8) NULL,
	[ProcessadorNFe] [varchar](10) NULL,
	[DataSaida] [datetime] NULL,
	[DataVencimentoMovimento] [datetime] NULL,
	[ExportacaoUFEmbarque] [varchar](2) NULL,
	[AgenteVendaParticipante] [uniqueidentifier] NULL,
	[ExportacaoLocalEmbarque] [varchar](60) NULL,
	[ModeloCFReferenciado] [varchar](6) NULL,
	[Contrato] [uniqueidentifier] NULL,
	[NumeroPadrao] [uniqueidentifier] NULL,
	[AparelhoECF] [uniqueidentifier] NULL,
	[Peso] [float] NOT NULL,
	[Altura] [float] NOT NULL
);
CREATE TABLE #IME(
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[AgenteVenda] [uniqueidentifier] NULL,
	[AliquotaCOFINS] [float] NOT NULL,
	[AliquotaICMS] [float] NOT NULL,
	[AliquotaIPI] [float] NOT NULL,
	[AliquotaPIS] [float] NOT NULL,
	[Cabecalho] [uniqueidentifier] NULL,
	[Cabecalho_O] [int] NULL,
	[CFOP] [varchar](4) NOT NULL,
	[CodigoBarras] [varchar](30) NOT NULL,
	[DataPrevistaEntrega] [datetime] NULL,
	[DescontosRateados] [float] NOT NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[ItemECF] [varchar](6) NOT NULL,
	[ModalidadeBaseICMS] [varchar](1) NOT NULL,
	[ModalidadeBaseICMSST] [varchar](1) NOT NULL,
	[OrigemMercadoria] [varchar](1) NOT NULL,
	[PercMargemAdicICMSST] [float] NOT NULL,
	[Peso] [float] NOT NULL,
	[ProdutoFinal] [uniqueidentifier] NULL,
	[Quantidade] [float] NOT NULL,
	[QuantidadeQuitada] [bit] NOT NULL,
	[ReducaoBCICMS] [float] NOT NULL,
	[ReducaoBCICMSST] [float] NOT NULL,
	[SitTributariaCOFINS] [varchar](3) NOT NULL,
	[SitTributariaICMS] [varchar](3) NOT NULL,
	[SitTributariaIPI] [varchar](3) NOT NULL,
	[SitTributariaPIS] [varchar](3) NOT NULL,
	[StateSaldo] [varchar](20) NOT NULL,
	[StateSaldoOrigem] [varchar](25) NOT NULL,
	[TabelaPreco] [uniqueidentifier] NULL,
	[TipoAtualizacaoEstoque] [varchar](10) NOT NULL,
	[TipoUnidadeMedida] [varchar](10) NOT NULL,
	[TipoValorCOFINS] [uniqueidentifier] NULL,
	[TipoValorCOFINSST] [uniqueidentifier] NULL,
	[TipoValorICMS] [uniqueidentifier] NULL,
	[TipoValorICMSST] [uniqueidentifier] NULL,
	[TipoValorIPI] [uniqueidentifier] NULL,
	[TipoValorPIS] [uniqueidentifier] NULL,
	[TipoValorPISST] [uniqueidentifier] NULL,
	[TipoValorPrecoCusto] [uniqueidentifier] NULL,
	[UltimoPrecoCusto] [float] NOT NULL,
	[UltimoPrecoMedio] [float] NOT NULL,
	[ValorUnitario] [float] NOT NULL,
	[Volume] [float] NOT NULL,
	[SeguroRateado] [float] NOT NULL,
	[FreteRateado] [float] NOT NULL,
	[TipoValorTotal] [uniqueidentifier] NULL,
	[SolucaoDefeito] [text] NULL,
	[DefeitoReclamado] [text] NULL,
	[StateItemOS] [varchar](15) NOT NULL,
	[Serial] [varchar](100) NOT NULL,
	[OutrasDespesasRateado] [float] NOT NULL,
	[Fiscal] [uniqueidentifier] NULL,
	[AtualizaSaldoEstoque] [bit] NULL,
);
CREATE TABLE #PME (
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[Cabecalho] [uniqueidentifier] NULL,
	[CodigoBarras] [varchar](50) NULL,
	[DataVencimento] [datetime] NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[LinhaDigitavel] [varchar](50) NULL,
	[NrDocumento] [varchar](50) NULL,
	[Personalidade] [uniqueidentifier] NULL,
	[TEFDataHora] [datetime] NULL,
	[TEFNSU] [varchar](20) NOT NULL,
	[TEFRede] [varchar](20) NOT NULL,
	[TEFValor] [float] NOT NULL,
	[TipoDocParcelamento] [uniqueidentifier] NULL,
	[Valor] [float] NOT NULL,
	[NrParcela] [int] NOT NULL,
);
CREATE TABLE #CMEN (
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[Movimento] [uniqueidentifier] NULL,
	[Numerador] [uniqueidentifier] NULL,
	[Numero] [varchar](50) NOT NULL,
);
CREATE TABLE #OBS (
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[CabecalhoMovimentoEstoque] [uniqueidentifier] NULL,
	[Data] [datetime] NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[Texto] [text] NULL,
	[TipoObservacao] [uniqueidentifier] NULL,
	[Usuario] [uniqueidentifier] NULL,
);
/* \\\ END - Sessão que cria tabelas temporárias /// */


/* /// BEGIND - Sessão que popula tabelas temporárias \\\ */
insert into #CME select cme.* from #CMEs x inner join CabecalhoMovimentoEstoque cme on x.ECO_ID = cme.ECO_ID;
insert into #IME select ime.* from #CMEs x inner join ItemMovimentoEstoque ime on x.ECO_ID = ime.Cabecalho;
insert into #PME select pme.* from #CMEs x inner join ParcelaMovimentoEstoque pme on x.ECO_ID = pme.Cabecalho;
insert into #CMEN select cmen.* from #CMEs x inner join CabMovEstoqueNumero cmen on x.ECO_ID = cmen.Movimento;
insert into #OBS select obs.* from #CMEs x inner join ObsCabMovEstoque obs on x.ECO_ID = obs.CabecalhoMovimentoEstoque;
/* \\\ END - Sessão que popula tabelas temporárias /// */

/* /// BEGIND - Sessão que popula outra base de dados com os dados das tabelas temporárias \\\ */
use primeWARE_MrBrook2;

insert into CabecalhoMovimentoEstoque select * from #CME;
insert into ItemMovimentoEstoque select * from #IME;
insert into ParcelaMovimentoEstoque select * from #PME;
insert into CabMovEstoqueNumero select * from #CMEN;
insert into ObsCabMovEstoque select * from #OBS;

/* \\\ END - Sessão que popula outra base de dados com os dados das tabelas temporárias /// */

/* /// BEGIND - Sessão que deleta tabelas temporárias \\\ */
drop table #OBS;
drop table #CMEN;
drop table #PME;
drop table #IME;
drop table #CME;

drop table #CMEs;
/* \\\ END - Sessão que deleta tabelas temporárias /// */

