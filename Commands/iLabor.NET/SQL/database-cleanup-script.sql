use iLabor_VR;

set dateformat ymd;

declare @varDTIniProcessFull datetime = getdate();
declare @varDTIniProcessCurrently datetime;

declare @varDTFim datetime = '2010-12-31 23:59:59';

print 'Excluindo registros com datas menores/iguais à ' + convert(varchar, @varDTFim ,121)
print convert(varchar, GETDATE() ,121) + ' - Iniciando script (FULL)' 
print ''


set @varDTIniProcessCurrently = GETDATE();
print convert(varchar, GETDATE() ,121) + ' - Iniciando criação de tabelas temporárias';
create table #iLaborAuditoriaTMP (ID int);
create table #ProtocoloTMP (ID int);
create table #ProtocoloProcedimentoTMP (ID int);
create table #ProtocoloParcelamentoTMP (ID int);
create table #ProtocoloConvenioTMP (ID int);
create table #ProtocoloPortariaTMP (ID int);
create table #ProtocoloProcedimentoPendenciaTMP (ID int);
create table #ProtocoloProcedimentoVariavelTMP (ID int);
create table #Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoesTMP (ID int);
create table #Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicosTMP (ID int);
create table #OrcamentoTMP (ID int);
create table #OrcamentoProcedimentoTMP (ID int);
create table #MovimentoEstoqueTMP (ID int);
create table #MovimentoConferenciaTransferenciaTMP (ID int);
create table #MovimentoEstoqueCompraTMP (ID int);
create table #MovimentoEstoqueConveniadoTMP (ID int);
create table #MovimentoEstoqueInutilizadoTMP (ID int);
create table #MovimentoEstoqueRequisicaoTMP (ID int);
create table #MovimentoEstoqueTransferenciaTMP (ID int);
create table #MovimentoEstoqueItemTMP (ID int);

create table #MapaTrabalhoTMP (ID int);
create table #FaturaTMP (ID int);
create table #FaturaParcelamentoTMP (ID int);
create table #FaturaPlanoTMP (ID int);
create table #FaturaProcedimentoTMP (ID int);
create table #AuditoriaTMP (ID int);
create table #AuditoriaAcaoTMP (ID int);
create table #ObjetoAuditadoTMP (ID int);
create table #AtestadoTMP (ID int);
create table #ReciboTMP (ID int);
print convert(varchar, GETDATE() ,121) + ' (' + convert(varchar, getdate() - @varDTIniProcessCurrently, 114) + ') - ' + 'Criação de tabelas temporárias finalizada'
print ''


set @varDTIniProcessCurrently = GETDATE();
print convert(varchar, GETDATE() ,121) + ' - Iniciando inserção de registros em tabelas temporárias'
print 'Protocolo';
insert into #ProtocoloTMP select p.ECO_ID from Protocolo p where p.Data_Entrada <= @varDTFim;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #ProtocoloTMP p inner join iLaborAuditoria ia on p.ID = ia.Protocolo;
print 'ProtocoloProcedimento';
insert into #ProtocoloProcedimentoTMP select pp.ECO_ID from #ProtocoloTMP p inner join Protocolo_Procedimento pp on p.ID = pp.Protocolo;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #ProtocoloProcedimentoTMP pp inner join iLaborAuditoria ia on pp.ID = ia.Protocolo_Procedimento;
print 'ProtocoloParcelamento';
insert into #ProtocoloParcelamentoTMP select pp.ECO_ID from #ProtocoloTMP p inner join Protocolo_Parcelamento pp on p.ID = pp.Protocolo;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #ProtocoloParcelamentoTMP pp inner join iLaborAuditoria ia on pp.ID = ia.Protocolo_Parcelamento;
print 'ProtocoloConvenio';
insert into #ProtocoloConvenioTMP select pc.ECO_ID from #ProtocoloTMP p inner join Protocolo_Convenio pc on p.ID = pc.ECO_ID;
print 'ProtocoloPortaria';
insert into #ProtocoloPortariaTMP select pp.ECO_ID from #ProtocoloTMP p inner join Protocolo_Portaria pp on p.ID = pp.ECO_ID;
print 'ProtocoloProcedimentoPendencia';
insert into #ProtocoloProcedimentoPendenciaTMP select ppp.ECO_ID from #ProtocoloProcedimentoTMP pp inner join Protocolo_Procedimento_Pendencia ppp on pp.ID = ppp.Protocolo_Procedimento;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #ProtocoloProcedimentoPendenciaTMP ppp inner join iLaborAuditoria ia on ppp.ID = ia.Protocolo_Procedimento_Pendencia;
print 'ProtocoloProcedimentoVariavel';
insert into #ProtocoloProcedimentoVariavelTMP select ppv.ECO_ID from #ProtocoloProcedimentoTMP pp inner join Protocolo_Procedimento_Variavel ppv on pp.ID = ppv.Protocolo_Procedimento;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #ProtocoloProcedimentoVariavelTMP ppv inner join iLaborAuditoria ia on ppv.ID = ia.Protocolo_Procedimento_Variavel;
print 'Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes';
insert into #Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoesTMP select ppvv.ECO_ID from #ProtocoloProcedimentoVariavelTMP ppv inner join Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes ppvv on ppv.ID = ppvv.Protocolo_Procedimento_Variavels;
print 'Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos';
insert into #Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicosTMP select ppmm.ECO_ID from #ProtocoloProcedimentoTMP pp inner join Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppmm on pp.ID = ppmm.Protocolo_Procedimentos;

print 'Orcamento';
insert into #OrcamentoTMP select o.ECO_ID from Orcamento o where o.Data <= @varDTFim;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #OrcamentoTMP o inner join iLaborAuditoria ia on o.ID = ia.Orcamento;
print 'OrcamentoProcedimento';
insert into #OrcamentoProcedimentoTMP select op.ECO_ID from #OrcamentoTMP o inner join Orcamento_Procedimento op on o.ID = op.Orcamento;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #OrcamentoProcedimentoTMP op inner join iLaborAuditoria ia on op.ID = ia.Orcamento_Procedimento;

print 'MovimentoEstoque';
insert into #MovimentoEstoqueTMP select me.ECO_ID from MovimentoEstoque me where me.DataMovimento <= @varDTFim;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #MovimentoEstoqueTMP me inner join iLaborAuditoria ia on me.ID = ia.MovimentoEstoque;
print 'MovimentoConferenciaTransferencia'
insert into #MovimentoConferenciaTransferenciaTMP select mct.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoConferenciaTransferencia mct on me.ID = mct.ECO_ID
print 'MovimentoEstoqueCompra'
insert into #MovimentoEstoqueCompraTMP select mec.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoEstoqueCompra mec on me.ID = mec.ECO_ID
print 'MovimentoEstoqueConveniado'
insert into #MovimentoEstoqueConveniadoTMP select mec.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoEstoqueConveniado mec on me.ID = mec.ECO_ID
print 'MovimentoEstoqueInutilizado'
insert into #MovimentoEstoqueInutilizadoTMP select mei.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoEstoqueInutilizado mei on me.ID = mei.ECO_ID
print 'MovimentoEstoqueRequisicao'
insert into #MovimentoEstoqueRequisicaoTMP select mer.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoEstoqueRequisicao mer on me.ID = mer.ECO_ID
print 'MovimentoEstoqueTransferencia'
insert into #MovimentoEstoqueTransferenciaTMP select met.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoEstoqueTransferencia met on me.ID = met.ECO_ID
print 'MovimentoEstoqueItem'
insert into #MovimentoEstoqueItemTMP select mei.ECO_ID from #MovimentoEstoqueTMP me inner join MovimentoEstoqueItem mei on me.ID = mei.MovimentoEstoque
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #MovimentoEstoqueItemTMP mei inner join iLaborAuditoria ia on mei.ID = ia.MovimentoEstoqueItem

print 'MapaTrabalho';
insert into #MapaTrabalhoTMP select mp.ECO_ID from MapaTrabalho mp where mp.Data_Geracao <= @varDTFim;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #MapaTrabalhoTMP mp inner join iLaborAuditoria ia on mp.ID = ia.MapaTrabalho;

print 'Fatura';
insert into #FaturaTMP select f.ECO_ID from Fatura f where f.Data_Teto <= @varDTFim;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #FaturaTMP f inner join iLaborAuditoria ia on f.ID = ia.Fatura;
print 'FaturaParcelamento';
insert into #FaturaParcelamentoTMP select fp.ECO_ID from #FaturaTMP f inner join Fatura_Parcelamento fp on f.ID = fp.Fatura;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #FaturaParcelamentoTMP fp inner join iLaborAuditoria ia on fp.ID = ia.Fatura_Parcelamento;
print 'FaturaPlano';
insert into #FaturaPlanoTMP select fp.ECO_ID from #FaturaTMP f inner join Fatura_Plano fp on f.ID = fp.Fatura;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #FaturaPlanoTMP fp inner join iLaborAuditoria ia on fp.ID = ia.Fatura_Plano;
print 'FaturaProcedimento';
insert into #FaturaProcedimentoTMP select fp.ECO_ID from #FaturaTMP f inner join Fatura_Procedimento fp on f.ID = fp.Fatura;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #FaturaProcedimentoTMP fp inner join iLaborAuditoria ia on fp.ID = ia.Fatura_Procedimento;

print 'Auditoria';
insert into #AuditoriaTMP select a.ECO_ID from Auditoria a where a.Data <= @varDTFim;
print 'AuditoriaAcao';
insert into #AuditoriaAcaoTMP select aa.ECO_ID from #AuditoriaTMP a inner join AuditoriaAcao aa on a.ID = aa.Auditoria;
print 'ObjetoAuditado';
insert into #ObjetoAuditadoTMP select oa.ECO_ID from #AuditoriaTMP a inner join ObjetoAuditado oa on a.ID = oa.Auditoria;

print 'Atestado';
insert into #AtestadoTMP select a.ECO_ID from #ProtocoloTMP p inner join Atestado a on p.ID = a.Protocolo;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #AtestadoTMP a inner join iLaborAuditoria ia on a.ID = ia.Atestado;

print 'Recibo';
insert into #ReciboTMP select r.ECO_ID from #ProtocoloTMP p inner join Recibo r on p.ID = r.Protocolo;
insert into #iLaborAuditoriaTMP select ia.ECO_ID from #ReciboTMP r inner join iLaborAuditoria ia on r.ID = ia.Atestado;
print convert(varchar, GETDATE() ,121) + ' (' + convert(varchar, getdate() - @varDTIniProcessCurrently, 114) + ') - ' + 'Inserção de registros finalizada em tabelas temporárias'
print ''


set @varDTIniProcessCurrently = GETDATE();
print convert(varchar, GETDATE() ,121) + ' - Iniciando comandos para exclusão de registros'
delete from iLaborAuditoria where exists(select ID from #iLaborAuditoriaTMP where ECO_ID = ID);
delete from Protocolo where exists(select ID from #ProtocoloTMP where ECO_ID = ID);
delete from Protocolo_Procedimento where exists(select ID from #ProtocoloProcedimentoTMP where ECO_ID = ID);
delete from Protocolo_Parcelamento where exists(select ID from #ProtocoloParcelamentoTMP where ECO_ID = ID);
delete from Protocolo_Convenio where exists(select ID from #ProtocoloConvenioTMP where ECO_ID = ID);
delete from Protocolo_Portaria where exists(select ID from #ProtocoloPortariaTMP where ECO_ID = ID);
delete from Protocolo_Procedimento_Pendencia where exists(select ID from #ProtocoloProcedimentoPendenciaTMP where ECO_ID = ID);
delete from Protocolo_Procedimento_Variavel where exists(select ID from #ProtocoloProcedimentoVariavelTMP where ECO_ID = ID);
delete from Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes where exists(select ID from #Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoesTMP where ECO_ID = ID);
delete from Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos where exists(select ID from #Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicosTMP where ECO_ID = ID);
delete from Orcamento where exists(select ID from #OrcamentoTMP where ECO_ID = ID);
delete from Orcamento_Procedimento where exists(select ID from #OrcamentoProcedimentoTMP where ECO_ID = ID);
delete from MovimentoEstoque where exists(select ID from #MovimentoEstoqueTMP where ECO_ID = ID);
delete from MovimentoConferenciaTransferencia where exists(select ID from #MovimentoConferenciaTransferenciaTMP where ECO_ID = ID);
delete from MovimentoEstoqueCompra where exists(select ID from #MovimentoEstoqueCompraTMP where ECO_ID = ID);
delete from MovimentoEstoqueConveniado where exists(select ID from #MovimentoEstoqueConveniadoTMP where ECO_ID = ID);
delete from MovimentoEstoqueInutilizado where exists(select ID from #MovimentoEstoqueInutilizadoTMP where ECO_ID = ID);
delete from MovimentoEstoqueRequisicao where exists(select ID from #MovimentoEstoqueRequisicaoTMP where ECO_ID = ID);
delete from MovimentoEstoqueTransferencia where exists(select ID from #MovimentoConferenciaTransferenciaTMP where ECO_ID = ID);
delete from MovimentoEstoqueItem where exists(select ID from #MovimentoEstoqueItemTMP where ECO_ID = ID);

delete from MapaTrabalho where exists(select ID from #MapaTrabalhoTMP where ECO_ID = ID);
delete from Fatura where exists(select ID from #FaturaTMP where ECO_ID = ID);
delete from Fatura_Parcelamento where exists(select ID from #FaturaParcelamentoTMP where ECO_ID = ID);
delete from Fatura_Plano where exists(select ID from #FaturaPlanoTMP where ECO_ID = ID);
delete from Fatura_Procedimento where exists(select ID from #FaturaProcedimentoTMP where ECO_ID = ID);
delete from Auditoria where exists(select ID from #AuditoriaTMP where ECO_ID = ID);
delete from AuditoriaAcao where exists(select ID from #AuditoriaAcaoTMP where ECO_ID = ID);
delete from ObjetoAuditado where exists(select ID from #ObjetoAuditadoTMP where ECO_ID = ID);
delete from Atestado where exists(select ID from #AtestadoTMP where ECO_ID = ID);
delete from Recibo where exists(select ID from #ReciboTMP where ECO_ID = ID);
print convert(varchar, GETDATE() ,121) + ' (' + convert(varchar, getdate() - @varDTIniProcessCurrently, 114) + ') - ' + 'Comandos para exclusão de registros finalizado'
print ''


set @varDTIniProcessCurrently = GETDATE();
print convert(varchar, GETDATE() ,121) + ' - Iniciando exclusão de tabelas temporárias'
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#iLaborAuditoriaTMP%') drop table #iLaborAuditoriaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloTMP%') drop table #ProtocoloTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloProcedimentoTMP%') drop table #ProtocoloProcedimentoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloParcelamentoTMP%') drop table #ProtocoloParcelamentoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloConvenioTMP%') drop table #ProtocoloConvenioTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloPortariaTMP%') drop table #ProtocoloPortariaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloProcedimentoPendenciaTMP%') drop table #ProtocoloProcedimentoPendenciaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ProtocoloProcedimentoVariavelTMP%') drop table #ProtocoloProcedimentoVariavelTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoesTMP%') drop table #Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoesTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicosTMP%') drop table #Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicosTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#OrcamentoTMP%') drop table #OrcamentoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#OrcamentoProcedimentoTMP%') drop table #OrcamentoProcedimentoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueTMP%') drop table #MovimentoEstoqueTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoConferenciaTransferenciaTMP%') drop table #MovimentoConferenciaTransferenciaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueCompraTMP%') drop table #MovimentoEstoqueCompraTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueConveniadoTMP%') drop table #MovimentoEstoqueConveniadoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueInutilizadoTMP%') drop table #MovimentoEstoqueInutilizadoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueRequisicaoTMP%') drop table #MovimentoEstoqueRequisicaoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueTransferenciaTMP%') drop table #MovimentoEstoqueTransferenciaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MovimentoEstoqueItemTMP%') drop table #MovimentoEstoqueItemTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MapaTrabalhoTMP%') drop table #MapaTrabalhoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#FaturaTMP%') drop table #FaturaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#FaturaParcelamentoTMP%') drop table #FaturaParcelamentoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#FaturaPlanoTMP%') drop table #FaturaPlanoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#FaturaProcedimentoTMP%') drop table #FaturaProcedimentoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#AuditoriaTMP%') drop table #AuditoriaTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#AuditoriaAcaoTMP%') drop table #AuditoriaAcaoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ObjetoAuditadoTMP%') drop table #ObjetoAuditadoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#AtestadoTMP%') drop table #AtestadoTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#ReciboTMP%') drop table #ReciboTMP;
print convert(varchar, GETDATE() ,121) + ' (' + convert(varchar, getdate() - @varDTIniProcessCurrently, 114) + ') - ' + 'Tabelas temporárias excluídas';
print '';

print convert(varchar, GETDATE() ,121) + ' (' + convert(varchar, getdate() - @varDTIniProcessFull, 114) + ') - ' + 'Scrip (FULL) finalizado';
