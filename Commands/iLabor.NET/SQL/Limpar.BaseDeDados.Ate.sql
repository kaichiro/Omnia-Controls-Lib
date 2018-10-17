use iLabor_VR;
set dateformat ymd;

declare @dtIni datetime;
set @dtIni = GETDATE();

declare @varData datetime;
set @varData = '2012-12-31 23:59:59';

declare @pDTIni datetime;

declare @varSeparadoLinha varchar(128);
set @varSeparadoLinha = '--------------------------------------------------------------------------------------------' + CHAR(13) + CHAR(10);

  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Iniciando script de deleção de dados anteriores à ' + CONVERT(varchar, @varData, 121);
 
--update Protocolo_Procedimento set Status = 'Coletando.Aguardando' , StateFatura = 'Aberto' , ProcedimentoAgrupador = null, MapaTrabalho = null where Data_Recepcao <= @varData 

create table #Fatura_ (FaturaID int, NrFatura varchar(16), DtTeto datetime);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Populando tabela temporária (#Fatura_)';
insert into #Fatura_ select f.ECO_ID FaturaID, f.Numero_Fatura, f.Data_Teto from Fatura f where f.Data_Teto <= @varData;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Fatura_Procedimento)'
delete from Fatura_Procedimento where exists (select FaturaID from #Fatura_ where Fatura = FaturaID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Fatura)'
delete from Fatura where exists (select FaturaID from #Fatura_ where ECO_ID = FaturaID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#Fatura_)';
drop table #Fatura_;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print convert(varchar, GETDATE() ,121) + ' - Iniciando deleção (MapaTrabalho)'
delete from MapaTrabalho where Data_Geracao <= @varData;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);


create table #Protocolos (ProtocoloId int);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Populando tabela temporária (#Protocolos)'
insert into #Protocolos select p.ECO_ID from Protocolo p where p.Data_Entrada <= @varData;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
create table #ProtocolosProcedimentos (ProtocoloId int, ProtocoloProcedimentoId int);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Populando tabela temporária (#ProtocolosProcedimentos)'
insert into #ProtocolosProcedimentos select p.ProtocoloId, pp.ECO_ID from #Protocolos p inner join Protocolo_Procedimento pp on p.ProtocoloId = pp.Protocolo where pp.Data_Recepcao <= @varData;

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Convenio)'
delete from Protocolo_Convenio where exists(select ProtocoloId from #Protocolos where ProtocoloId = ECO_ID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Portaria)'
delete from Protocolo_Portaria where exists(select ProtocoloId from #Protocolos where ProtocoloId = ECO_ID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Parcelamento)'
delete from Protocolo_Parcelamento where exists(select ProtocoloId from #Protocolos where ProtocoloId = Protocolo);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
create table #ProtocoloProcedimentoVariavel (ProtocoloProcedimentoId int, ProtocoloProcedimentoVariavelId int)

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Populando tabela temporária (#ProtocoloProcedimentoVariavel)'
insert into #ProtocoloProcedimentoVariavel select pp.ProtocoloProcedimentoId, ppv.ECO_ID from #ProtocolosProcedimentos pp inner join Protocolo_Procedimento_Variavel  ppv on pp.ProtocoloProcedimentoId = ppv.ECO_ID

create table #PPVE (ppvId int);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Populando tabela temporária (#PPVE)'
insert into #PPVE select x.Protocolo_Procedimento_Variavels from Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes x;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes)'
delete from Protocolo_Procedimento_VariavelProtocolo_Procedimento_VariavelsProcedimento_Variavel_ExcecaoExcecoes where exists (select ppvId from #PPVE where ppvId = Protocolo_Procedimento_Variavels);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#PPVE)'
drop table #PPVE;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Procedimento_Variavel)'
delete from Protocolo_Procedimento_Variavel where exists (select 1 from #ProtocolosProcedimentos where ProtocoloProcedimentoId = ECO_ID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária(#ProtocoloProcedimentoVariavel)'
drop table #ProtocoloProcedimentoVariavel;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Procedimento_Pendencia)'
delete from Protocolo_Procedimento_Pendencia where exists(select 1 from #ProtocolosProcedimentos where ProtocoloProcedimentoId = Protocolo_Procedimento);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos)'
delete from Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos where exists(select ProtocoloProcedimentoId from #ProtocolosProcedimentos where Protocolo_Procedimentos = ProtocoloProcedimentoId);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo_Procedimento)'
delete from Protocolo_Procedimento where exists(select ProtocoloProcedimentoId from #ProtocolosProcedimentos where ProtocoloProcedimentoId = ECO_ID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Protocolo)'
delete from Protocolo where exists (select ProtocoloId from #Protocolos where ProtocoloId = ECO_ID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#ProtocolosProcedimentos)'
drop table #ProtocolosProcedimentos;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#Protocolos)'
drop table #Protocolos;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);
  
  print @varSeparadoLinha 



create table #Au (AuId int);
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#Protocolos)'
insert into #Au select x.ECO_ID from Auditoria x where x.Data <= @varData;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

create table #AA (AuId int, aaId int);
  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Populando tabela temporária (#AA - Auditoria)'
insert into #AA select x.Auditoria, x.ECO_ID from AuditoriaAcao x;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (AuditoriaAcao)'
delete from AuditoriaAcao where exists(select x.AuId from #AA x where AuId = x.AuId);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#AA - Auditoria)'
drop table #AA;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando registros (Auditoria)'
delete from Auditoria where exists(select AuId from #Au where AuId = ECO_ID);
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);

  set @pDTIni = GETDATE();
  print @varSeparadoLinha + convert(varchar, GETDATE() ,121) + ' - Deletando tabela temporária (#Au)'
drop table #Au;
  print convert(varchar, GETDATE() ,121) + ' - ' + convert(varchar, getdate() - @pDTIni, 114);


declare @dtFim datetime;
set @dtFim = GETDATE();
print convert(varchar, @dtFim,121) + ' finalizado. Tempo gsato = '  + convert(varchar, @dtFim - @dtIni, 114);
