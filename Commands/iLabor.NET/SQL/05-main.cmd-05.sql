use iLabor;

if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MedicosTMP%') drop table #MedicosTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#IDsTMP%') drop table #IDsTMP;

create table #MedicosTMP (
	QuantidadeRepetidos int
	, CRM varchar(64)
	, Nome varchar(256)
	, Sigle_Conselho varchar(64)
	, UF_Conselho varchar(16)
	, MedicoID int
	, QuantidadeProtocolos int
);
create table #IDsTMP (id int, qtdeProts int, qtdeProcs int);

with MedicosRepetidos as (
	select 
	COUNT(md.ECO_ID) QuantidadeRepetidos
	, md.CRM
	, md.Nome
	, md.Sigla_Conselho
	, md.UF_Conselho
	from Medico md
	group by
	md.CRM
	, md.Nome
	, md.Sigla_Conselho
	, md.UF_Conselho
	having COUNT(md.ECO_ID) = 2
)
, infos010 as (
	select
	mr.QuantidadeRepetidos
	, mr.CRM
	, mr.Nome
	, mr.Sigla_Conselho
	, mr.UF_Conselho
	, md.ECO_ID MedicoID
	from MedicosRepetidos mr
	inner join Medico md 
	on mr.CRM = md.CRM
	and mr.Nome = md.Nome 
	and mr.Sigla_Conselho = md.Sigla_Conselho
	and mr.UF_Conselho = md.UF_Conselho
)
, infos020 as (
	select
	x.QuantidadeRepetidos
	, x.CRM
	, x.Nome
	, x.Sigla_Conselho
	, x.UF_Conselho
	, x.MedicoID
	, (select COUNT(p.ECO_ID) from Protocolo p where x.MedicoID = p.Medico) QuantidadeProtocolos
--	, (select COUNT(pp.ECO_ID) from Protocolo_Procedimento pp inner join Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppm on pp.ECO_ID = ppm.Protocolo_Procedimentos where x.MedicoID = ppm.Medicos) QuantidadeProtocolos
	from infos010 x
)
	insert into #MedicosTMP
	select top 2
	x.QuantidadeRepetidos
	, x.CRM
	, x.Nome
	, x.Sigla_Conselho
	, x.UF_Conselho
	, x.MedicoID
	, x.QuantidadeProtocolos
	from infos020 x
	where x.QuantidadeProtocolos between 2 and 5
	order by x.Nome, x.QuantidadeProtocolos desc;

--select x.* from #MedicosTMP x


declare @QuantidadeRepetidos int;
declare @CRM varchar(64);
declare @Nome varchar(256);
declare @Sigle_Conselho varchar(64);
declare @UF_Conselho varchar(16);
declare @MedicoID int;
declare @QuantidadeProtocolos int;

declare MedicosCRS CURSOR FOR select * from #MedicosTMP;
OPEN MedicosCRS;
FETCH NEXT FROM MedicosCRS INTO @QuantidadeRepetidos, @CRM, @Nome, @Sigle_Conselho, @UF_Conselho, @MedicoID, @QuantidadeProtocolos;
WHILE @@FETCH_STATUS = 0
BEGIN

--	select @CRM, @Nome, @Sigle_Conselho, @UF_Conselho;

	insert into #IDsTMP
		select md.ECO_ID
		, (select COUNT(p.ECO_ID) from Protocolo p where md.ECO_ID = p.Medico) QuantidadeProtocolos
		, (select COUNT(pp.ECO_ID) from Protocolo_Procedimento pp inner join Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppm on pp.ECO_ID = ppm.Protocolo_Procedimentos where md.ECO_ID = ppm.Medicos) QuantidadeProcedimentos
		from Medico md 
		where md.CRM = @CRM 
		and md.Nome = @Nome 
		and md.Sigla_Conselho = @Sigle_Conselho 
		and md.UF_Conselho = @UF_Conselho
		order by 3 desc, 2 desc;
	
--	select 'todos', * from #IDsTMP;
	
	declare @idDestino int = (select top 1 id from #IDsTMP);
--	select 'destino', @idDestino;
	
	select Nome
	, 'update Protocolo set Medico = ' + rtrim(ltrim(str(@idDestino))) + ' where Medico = ' + rtrim(ltrim(str(ECO_ID))) + ';'  Update_Protocolo
	, 'update Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos set Medicos = ' + rtrim(ltrim(str(@idDestino))) + ' where Medicos = ' + rtrim(ltrim(str(ECO_ID))) + ';' Update_PPM
	, 'delete from Medico where ECO_ID = ' + rtrim(ltrim(str(ECO_ID))) + ';' Delete_Medico
	from Medico where exists (select id from #IDsTMP where id <> @idDestino and id = ECO_ID);


	truncate table #IDsTMP;
	FETCH NEXT FROM MedicosCRS INTO @QuantidadeRepetidos, @CRM, @Nome, @Sigle_Conselho, @UF_Conselho, @MedicoID, @QuantidadeProtocolos;
END
CLOSE MedicosCRS;
DEALLOCATE MedicosCRS;



if exists(select * from tempdb.dbo.sysobjects o where o.name like '#MedicosTMP%') drop table #MedicosTMP;
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#IDsTMP%') drop table #IDsTMP;
