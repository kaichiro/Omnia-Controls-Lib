/* Seta a base de dados */
use iLabor

/* Descobre quais os tipos de StateFatura */
select distinct pp.StateFatura 
from Protocolo_Procedimento pp 
order by pp.StateFatura

/* Descobre quantos registros estão com dados inválidos */
select
	fp.Fatura, COUNT(fp.Fatura)
from Protocolo_Procedimento pp
	inner join Fatura_Procedimento fp on pp.ECO_ID = fp.Protocolo_Procedimento
where pp.StateFatura = 'Faturado'
	and not exists(
		select f.ECO_ID from Fatura f where fp.Fatura = f.ECO_ID 
	)
group by fp.Fatura
order by COUNT(fp.Fatura) desc

/* Script que deleta registros inválidos  de itens de Fatura*/
/* /// BEGIN \\\ */
create table #FatProc (ID int)
insert into #FatProc
select
	fp.ECO_ID
from Protocolo_Procedimento pp
	inner join Fatura_Procedimento fp on pp.ECO_ID = fp.Protocolo_Procedimento
where pp.StateFatura = 'Faturado'
	and not exists(
		select f.ECO_ID from Fatura f where fp.Fatura = f.ECO_ID 
	)
delete from Fatura_Procedimento where exists(select fp.ID from #FatProc fp where fp.ID = ECO_ID)
drop table #FatProc
/* \\\ END /// */

/* Script que atualiza registros de itens de Protocolo */
/* /// BEGIN \\\ */
create table #ProtProc (ID int)
insert into #ProtProc
select pp.ECO_ID
from Protocolo_Procedimento pp
where pp.StateFatura = 'Faturado'
and
not exists(
	select fp.ECO_ID from Fatura_Procedimento fp where pp.ECO_ID = fp.Protocolo_Procedimento
)
update Protocolo_Procedimento set StateFatura = 'Aberto' where exists(select pp.ID from #ProtProc pp where pp.ID = ECO_ID)
drop table #ProtProc
/* \\\ END /// */
