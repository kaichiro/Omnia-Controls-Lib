/****** Object:  UDF    Script Date: 03/11/2019 09:08:07 ******/
-- =============================================
-- Author:		Kaichiro Fukuda
-- Create date: 03/11/2019 09:08:07
-- Description:	script for database integrity approval, based on protocol processing test
-- =============================================

use iLaborTeste2;

select 
'union all select ECO_ID ID_ from '+CLASSNAME+' '
from ECO_TYPE
where not CLASSNAME like 'ECO%'
order by CLASSNAME;


with ids as (
          select ECO_ID ID_ from Amostra 
union all select ECO_ID ID_ from Aparelho 
union all select ECO_ID ID_ from Aparelho_Procedimento 
union all select ECO_ID ID_ from Aparelho_Variavel 
union all select ECO_ID ID_ from Atestado 
union all select ECO_ID ID_ from AtestadoTipo 
union all select ECO_ID ID_ from Auditoria 
union all select ECO_ID ID_ from AuditoriaAcao 
union all select ECO_ID ID_ from AuditoriaEvento 
union all select ECO_ID ID_ from Aviso 
union all select ECO_ID ID_ from BiometriaPaciente 
union all select ECO_ID ID_ from Caixa 
union all select ECO_ID ID_ from Campo_Protocolo 
union all select ECO_ID ID_ from CampoClasseConsulta 
union all select ECO_ID ID_ from CampoConsultaRapida 
union all select ECO_ID ID_ from CampoLookUpParametro 
union all select ECO_ID ID_ from CEPBairro 
union all select ECO_ID ID_ from CEPLocalidade 
union all select ECO_ID ID_ from CEPLogradouro 
union all select ECO_ID ID_ from ClasseConsulta 
union all select ECO_ID ID_ from ColunaConsultaRapida 
union all select ECO_ID ID_ from ComposicaoDoCaixa 
union all select ECO_ID ID_ from ConfiguracaoFeriado 
union all select ECO_ID ID_ from Configuration 
union all select ECO_ID ID_ from Consulta 
union all select ECO_ID ID_ from ConsultaRapida 
union all select ECO_ID ID_ from ConsultaRapidaConsultaRapidasUsuarioUsuarios 
union all select ECO_ID ID_ from Controle_Ponto 
union all select ECO_ID ID_ from ControleQtde_Produto 
union all select ECO_ID ID_ from Convenio 
union all select ECO_ID ID_ from Convenio_Campo 
union all select ECO_ID ID_ from Convenio_Fatura 
union all select ECO_ID ID_ from Convenio_Fatura_Campo 
union all select ECO_ID ID_ from Convenio_Plano 
union all select ECO_ID ID_ from Convenio_Plano_CampoObrigatorio 
union all select ECO_ID ID_ from Convenio_Plano_Excecao 
union all select ECO_ID ID_ from Convenio_Plano_NaoCoberto 
union all select ECO_ID ID_ from Convenio_Plano_Suspensao 
union all select ECO_ID ID_ from Endereco 
union all select ECO_ID ID_ from EntradaEstoque 
union all select ECO_ID ID_ from Especialidade 
union all select ECO_ID ID_ from EventoAuditado 
union all select ECO_ID ID_ from Fatura 
union all select ECO_ID ID_ from Fatura_Parcelamento 
union all select ECO_ID ID_ from Fatura_Plano 
union all select ECO_ID ID_ from Fatura_Procedimento 
union all select ECO_ID ID_ from Feriado 
union all select ECO_ID ID_ from FeriadoLocal 
union all select ECO_ID ID_ from FeriadoPadrao 
union all select ECO_ID ID_ from Fornecedor_Produto 
union all select ECO_ID ID_ from Frase 
union all select ECO_ID ID_ from Grupo_Produto 
union all select ECO_ID ID_ from iLaborAuditoria 
union all select ECO_ID ID_ from ItemAuditado 
union all select ECO_ID ID_ from Laboratorio_Apoio 
union all select ECO_ID ID_ from Lote_Produto 
union all select ECO_ID ID_ from MapaTrabalho 
union all select ECO_ID ID_ from Medico 
union all select ECO_ID ID_ from MedicoConvenio 
union all select ECO_ID ID_ from MenuUsuario 
union all select ECO_ID ID_ from Metodo 
union all select ECO_ID ID_ from Movimento_Caixa 
union all select ECO_ID ID_ from MovimentoConferenciaTransferencia 
union all select ECO_ID ID_ from MovimentoEstoque 
union all select ECO_ID ID_ from MovimentoEstoqueCompra 
union all select ECO_ID ID_ from MovimentoEstoqueConveniado 
union all select ECO_ID ID_ from MovimentoEstoqueInutilizado 
union all select ECO_ID ID_ from MovimentoEstoqueItem 
union all select ECO_ID ID_ from MovimentoEstoqueRequisicao 
union all select ECO_ID ID_ from MovimentoEstoqueTransferencia 
union all select ECO_ID ID_ from Numerador 
union all select ECO_ID ID_ from ObjetoAuditado 
union all select ECO_ID ID_ from Orcamento 
union all select ECO_ID ID_ from Orcamento_Procedimento 
union all select ECO_ID ID_ from Paciente 
union all select ECO_ID ID_ from ParametroConsulta 
union all select ECO_ID ID_ from Procedimento 
union all select ECO_ID ID_ from Procedimento_Excecao_Usuario 
union all select ECO_ID ID_ from Procedimento_Laudo 
union all select ECO_ID ID_ from Procedimento_Laudo_Excecao 
union all select ECO_ID ID_ from Procedimento_Variavel 
union all select ECO_ID ID_ from Procedimento_Variavel_Excecao 
union all select ECO_ID ID_ from Procedimento_Variavel_Excecao_Usuario 
union all select ECO_ID ID_ from Procedimento_Variavel_Lista 
union all select ECO_ID ID_ from Procedimento_Variavel_Referencia 
union all select ECO_ID ID_ from ProcedimentoGrupoDeProcedimentosProcedimentoProcedimentosDoGrupo 
union all select ECO_ID ID_ from Produto 
union all select ECO_ID ID_ from ProdutoFornecido 
union all select ECO_ID ID_ from Protocolo 
union all select ECO_ID ID_ from Protocolo_Convenio 
union all select ECO_ID ID_ from Protocolo_Parcelamento 
union all select ECO_ID ID_ from Protocolo_Portaria 
union all select ECO_ID ID_ from Protocolo_Procedimento 
union all select ECO_ID ID_ from Protocolo_Procedimento_Pendencia 
union all select ECO_ID ID_ from Protocolo_Procedimento_Variavel 
union all select ECO_ID ID_ from Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes 
union all select ECO_ID ID_ from Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos 
union all select ECO_ID ID_ from Reagente 
union all select ECO_ID ID_ from Recibo 
union all select ECO_ID ID_ from Relatorio 
union all select ECO_ID ID_ from SaidaEstoque 
union all select ECO_ID ID_ from Saldo_Produto 
union all select ECO_ID ID_ from Setor 
union all select ECO_ID ID_ from SituacaoColeta 
union all select ECO_ID ID_ from Tabela_CID 
union all select ECO_ID ID_ from Tabela_Preco 
union all select ECO_ID ID_ from Tabela_Preco_Procedimento 
union all select ECO_ID ID_ from Tipo_Documento_Parcelamento 
union all select ECO_ID ID_ from TipoPonto 
union all select ECO_ID ID_ from Tubo 
union all select ECO_ID ID_ from Unidade 
union all select ECO_ID ID_ from UnidadeComissao 
union all select ECO_ID ID_ from UnidadeDeCaixa 
union all select ECO_ID ID_ from UnidadeEstoque 
union all select ECO_ID ID_ from Usuario 
union all select ECO_ID ID_ from UsuarioUsuariosConfigurationConfigurations )
delete from ECOModelRoot where not exists(select 1 from ids x where x.ID_ = ECO_ID);
