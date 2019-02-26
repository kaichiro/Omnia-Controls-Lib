/* Padrão para Date */
set dateformat ymd;

declare @p_data_ini datetime = '2019-02-15 15:25:00';
declare @p_data_fim datetime = '2019-02-19 23:59:59';

/* Base de Dados com informações a serem exportadas */
use primeWARE_Erro
print 'Setando ( [' + ltrim(rtrim(str(db_ID()))) + '] ' + db_name() + ') como base de dados corrente';

declare @p_tme_id uniqueidentifier = (select top 1 tme.ECO_ID from TipoMovimentoEstoque tme where tme.Descricao = 'NFC-E');
declare @p_und_id uniqueidentifier = (select top 1 und.ECO_ID from Unidade und where und.Descricao = 'Mr. Brook Gyn Shop');

/* Tabela temporária para guardar os ECO_ID's dos cabecalhos a serem exportados */
print 'Criando tabela temporária #CMEs';
create table #CMEs (ECO_ID uniqueidentifier);

/* Populando tabela temporária dos ECO_ID's dos cabecalhos a serem exportados */
print 'Populando tabela temporária #CMEs';
insert into #CMEs
	select cme.ECO_ID from CabecalhoMovimentoEstoque cme
	where cme.DataEmissao between @p_data_ini and @p_data_fim and cme.Unidade = @p_und_id and cme.TipoMovimentoEstoque = @p_tme_id
	order by cme.DataEmissao asc;

select 'Quantidade de cabecalhos selecionados: ', COUNT(x.ECO_ID) from #CMEs x;

/* /// BEGIND - Sessão que cria tabelas temporárias \\\ */
print 'Criando tabela temporária #CME';
CREATE TABLE #CME(
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

print 'Criando tabela temporária #IME';
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
	[AtualizaSaldoEstoque] [bit] NULL
);
print 'Criando tabela temporária #PME';
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
	[NrParcela] [int] NOT NULL
);
print 'Criando tabela temporária #CMEN';
CREATE TABLE #CMEN (
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[Movimento] [uniqueidentifier] NULL,
	[Numerador] [uniqueidentifier] NULL,
	[Numero] [varchar](50) NOT NULL
);
print 'Criando tabela temporária #OBS';
CREATE TABLE #OBS (
	[ECO_ID] [uniqueidentifier] NOT NULL,
	[CabecalhoMovimentoEstoque] [uniqueidentifier] NULL,
	[Data] [datetime] NULL,
	[ECO_TYPE] [smallint] NOT NULL,
	[Texto] [text] NULL,
	[TipoObservacao] [uniqueidentifier] NULL,
	[Usuario] [uniqueidentifier] NULL
);
/* \\\ END - Sessão que cria tabelas temporárias /// */


/* /// BEGIND - Sessão que popula tabelas temporárias \\\ */
print 'Inserindo registros em tabela temporária #CME';
insert into #CME select cme.* from #CMEs x inner join CabecalhoMovimentoEstoque cme on x.ECO_ID = cme.ECO_ID;
print 'Inserindo registros em tabela temporária #IME';
insert into #IME select ime.* from #CMEs x inner join ItemMovimentoEstoque ime on x.ECO_ID = ime.Cabecalho;
print 'Inserindo registros em tabela temporária #PME';
insert into #PME select pme.* from #CMEs x inner join ParcelaMovimentoEstoque pme on x.ECO_ID = pme.Cabecalho;
print 'Inserindo registros em tabela temporária #CMEN';
insert into #CMEN select cmen.* from #CMEs x inner join CabMovEstoqueNumero cmen on x.ECO_ID = cmen.Movimento;
print 'Inserindo registros em tabela temporária #OBS';
insert into #OBS select obs.* from #CMEs x inner join ObsCabMovEstoque obs on x.ECO_ID = obs.CabecalhoMovimentoEstoque;
/* \\\ END - Sessão que popula tabelas temporárias /// */

print '---'

/* /// BEGIND - Sessão que popula outra base de dados com os dados das tabelas temporárias \\\ */
use primeWARE;
print 'Setando ( [' + ltrim(rtrim(str(db_ID()))) + '] ' + db_name() + ') como base de dados corrente';

print 'Iniciando INSERT INTO em CabecalhoMovimentoEstoque';

insert into CabecalhoMovimentoEstoque
(ECO_ID
, AgenteVenda
, AntecipacaoTributaria
, CaixaRegistradora
, Cancelado
, CFOP
, DataAtualizacaoEstoque
, DataDigitacao
, DataEmissao
, ECO_TYPE
, EnderecoCobranca
, EnderecoEntrega
, FormaParcelamento
, Gerente
, ModeloDocFiscal
, MovimentoFinanceiroHeader
, MovimentoTitular
, NumeroCOO
, Personalidade
, QuantidadeQuitada
, SerieSubSerieNF
, SituacaoDocFiscal
, State
, TabelaPreco
, TipoMovimentoEstoque
, TipoTributacao
, TipoValorTotalBaseCOFINS
, TipoValorTotalBaseCOFINSST
, TipoValorTotalBaseICMS
, TipoValorTotalBaseICMSST
, TipoValorTotalBaseIPI
, TipoValorTotalBasePIS
, TipoValorTotalBasePISST
, TipoValorTotalCOFINS
, TipoValorTotalCOFINSST
, TipoValorTotalDescontos
, TipoValorTotalFrete
, TipoValorTotalICMS
, TipoValorTotalICMSST
, TipoValorTotalIPI
, TipoValorTotalNF
, TipoValorTotalOutros
, TipoValorTotalPIS
, TipoValorTotalPISST
, TipoValorTotalProduto
, TipoValorTotalSeguro
, Tributo
, Unidade
, UnidadeDestino
, RegimeTributario
, FinalidadeEmissao
, DataContingencia
, TipoEmissaoNFe
, JustificativaContingencia
, IESubstitutoTributario
, TipoOperacao
, VersaoProcessadorNFe
, FormatoImpressaoNFe
, ProcessadorNFe
, DataSaida
, DataVencimentoMovimento
, ExportacaoUFEmbarque
, AgenteVendaParticipante
, ExportacaoLocalEmbarque
, ModeloCFReferenciado
, Contrato
, NumeroPadrao
, AparelhoECF
, Peso
, Altura
)
select ECO_ID
, AgenteVenda
, AntecipacaoTributaria
, CaixaRegistradora
, Cancelado
, CFOP
, DataAtualizacaoEstoque
, DataDigitacao
, DataEmissao
, ECO_TYPE
, EnderecoCobranca
, EnderecoEntrega
, FormaParcelamento
, Gerente
, ModeloDocFiscal
, MovimentoFinanceiroHeader
, MovimentoTitular
, NumeroCOO
, Personalidade
, QuantidadeQuitada
, SerieSubSerieNF
, SituacaoDocFiscal
, State
, TabelaPreco
, TipoMovimentoEstoque
, TipoTributacao
, TipoValorTotalBaseCOFINS
, TipoValorTotalBaseCOFINSST
, TipoValorTotalBaseICMS
, TipoValorTotalBaseICMSST
, TipoValorTotalBaseIPI
, TipoValorTotalBasePIS
, TipoValorTotalBasePISST
, TipoValorTotalCOFINS
, TipoValorTotalCOFINSST
, TipoValorTotalDescontos
, TipoValorTotalFrete
, TipoValorTotalICMS
, TipoValorTotalICMSST
, TipoValorTotalIPI
, TipoValorTotalNF
, TipoValorTotalOutros
, TipoValorTotalPIS
, TipoValorTotalPISST
, TipoValorTotalProduto
, TipoValorTotalSeguro
, Tributo
, Unidade
, UnidadeDestino
, RegimeTributario
, FinalidadeEmissao
, DataContingencia
, TipoEmissaoNFe
, JustificativaContingencia
, IESubstitutoTributario
, TipoOperacao
, VersaoProcessadorNFe
, FormatoImpressaoNFe
, ProcessadorNFe
, DataSaida
, DataVencimentoMovimento
, ExportacaoUFEmbarque
, AgenteVendaParticipante
, ExportacaoLocalEmbarque
, ModeloCFReferenciado
, Contrato
, NumeroPadrao
, AparelhoECF
, Peso
, Altura
 from #CME;
print 'INSERT INTO em CabecalhoMovimentoEstoque finalizado';

print '---';

print 'Iniciando INSERT INTO em ItemMovimentoEstoque';
insert into ItemMovimentoEstoque
(ECO_ID
, AgenteVenda
, AliquotaCOFINS
, AliquotaICMS
, AliquotaIPI
, AliquotaPIS
, Cabecalho
, Cabecalho_O
, CFOP
, CodigoBarras
, DataPrevistaEntrega
, DescontosRateados
, ECO_TYPE
, ItemECF
, ModalidadeBaseICMS
, ModalidadeBaseICMSST
, OrigemMercadoria
, PercMargemAdicICMSST
, Peso
, ProdutoFinal
, Quantidade
, QuantidadeQuitada
, ReducaoBCICMS
, ReducaoBCICMSST
, SitTributariaCOFINS
, SitTributariaICMS
, SitTributariaIPI
, SitTributariaPIS
, StateSaldo
, StateSaldoOrigem
, TabelaPreco
, TipoAtualizacaoEstoque
, TipoUnidadeMedida
, TipoValorCOFINS
, TipoValorCOFINSST
, TipoValorICMS
, TipoValorICMSST
, TipoValorIPI
, TipoValorPIS
, TipoValorPISST
, TipoValorPrecoCusto
, UltimoPrecoCusto
, UltimoPrecoMedio
, ValorUnitario
, Volume
, SeguroRateado
, FreteRateado
, TipoValorTotal
, SolucaoDefeito
, DefeitoReclamado
, StateItemOS
, Serial
, OutrasDespesasRateado
, Fiscal
, AtualizaSaldoEstoque
) select ECO_ID
, AgenteVenda
, AliquotaCOFINS
, AliquotaICMS
, AliquotaIPI
, AliquotaPIS
, Cabecalho
, Cabecalho_O
, CFOP
, CodigoBarras
, DataPrevistaEntrega
, DescontosRateados
, ECO_TYPE
, ItemECF
, ModalidadeBaseICMS
, ModalidadeBaseICMSST
, OrigemMercadoria
, PercMargemAdicICMSST
, Peso
, ProdutoFinal
, Quantidade
, QuantidadeQuitada
, ReducaoBCICMS
, ReducaoBCICMSST
, SitTributariaCOFINS
, SitTributariaICMS
, SitTributariaIPI
, SitTributariaPIS
, StateSaldo
, StateSaldoOrigem
, TabelaPreco
, TipoAtualizacaoEstoque
, TipoUnidadeMedida
, TipoValorCOFINS
, TipoValorCOFINSST
, TipoValorICMS
, TipoValorICMSST
, TipoValorIPI
, TipoValorPIS
, TipoValorPISST
, TipoValorPrecoCusto
, UltimoPrecoCusto
, UltimoPrecoMedio
, ValorUnitario
, Volume
, SeguroRateado
, FreteRateado
, TipoValorTotal
, SolucaoDefeito
, DefeitoReclamado
, StateItemOS
, Serial
, OutrasDespesasRateado
, Fiscal
, AtualizaSaldoEstoque
 from #IME;
print 'INSERT INTO em ItemMovimentoEstoque finalizado';

print '---' ;

print 'Iniciando INSERT INTO em ParcelaMovimentoEstoque';
insert into ParcelaMovimentoEstoque
(ECO_ID
, Cabecalho
, CodigoBarras
, DataVencimento
, ECO_TYPE
, LinhaDigitavel
, NrDocumento
, Personalidade
, TEFDataHora
, TEFNSU
, TEFRede
, TEFValor
, TipoDocParcelamento
, Valor
, NrParcela
) select ECO_ID
, Cabecalho
, CodigoBarras
, DataVencimento
, ECO_TYPE
, LinhaDigitavel
, NrDocumento
, Personalidade
, TEFDataHora
, TEFNSU
, TEFRede
, TEFValor
, TipoDocParcelamento
, Valor
, NrParcela
 from #PME;
print 'INSERT INTO em ItemMovimentoEstoque ParcelaMovimentoEstoque';

print '---' ;

print 'Iniciando INSERT INTO em CabMovEstoqueNumero';
insert into CabMovEstoqueNumero (ECO_ID
, ECO_TYPE
, Movimento
, Numerador
, Numero
) select ECO_ID
, ECO_TYPE
, Movimento
, Numerador
, Numero
 from #CMEN;
print 'INSERT INTO em CabMovEstoqueNumero finalizado';

print '---' ;

print 'Iniciando INSERT INTO em ObsCavMovEstoque';
insert into ObsCabMovEstoque (ECO_ID
, CabecalhoMovimentoEstoque
, Data
, ECO_TYPE
, Texto
, TipoObservacao
, Usuario
) select ECO_ID
, CabecalhoMovimentoEstoque
, Data
, ECO_TYPE
, Texto
, TipoObservacao
, Usuario
 from #OBS;
print 'INSERT INTO em ObsCabMovEstoque finalizado';

print '---' ;

/* \\\ END - Sessão que popula outra base de dados com os dados das tabelas temporárias /// */

/* /// BEGIND - Sessão que deleta tabelas temporárias \\\ */
print 'Iniciando DROP TABLE #OBS';
drop table #OBS;
print 'Iniciando DROP TABLE #CMEN';
drop table #CMEN;
print 'Iniciando DROP TABLE #PME';
drop table #PME;
print 'Iniciando DROP TABLE #IME';
drop table #IME;
print 'Iniciando DROP TABLE #CME';
drop table #CME;

print 'Iniciando DROP TABLE #CMEs';
drop table #CMEs;

print 'DROP TABLE finalizado';

/* \\\ END - Sessão que deleta tabelas temporárias /// */
