use iLabor_VR;

create table #infos (ECO_ID int, YearMonth varchar(16), Year int);
insert into #infos
	select 
	p.ECO_ID
	, CONVERT(VARCHAR(7), p.Data_Entrada, 111) YearMonth
	, DATEPART(YEAR, p.Data_Entrada) Year
	from Protocolo p
;

select
COUNT(x.ECO_ID)
, x.Year
from #infos x
group by x.Year
order by x.Year 

select
COUNT(x.ECO_ID)
, x.YearMonth
from #infos x
group by x.YearMonth
order by x.YearMonth

/*
select
COUNT(x.ECO_ID)
, x.YearMonth
from #infos x
group by x.YearMonth
order by COUNT(x.ECO_ID) desc
*/

drop table #infos