use iLabor_VR;

with infos010 as
(
	select 
	p.ECO_ID
	, CONVERT(VARCHAR(7), p.Data_Entrada, 111) YearMonth
	, DATEPART(YEAR, p.Data_Entrada) Year
	from Protocolo p
)
select
COUNT(x.ECO_ID)
, x.YearMonth
from infos010 x
group by x.YearMonth
order by COUNT(x.ECO_ID) desc