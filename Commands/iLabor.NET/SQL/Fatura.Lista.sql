use iLabor;

set dateformat ymd;

declare @pDTIni datetime = '2018-01-01';
declare @pDTFim datetime = getdate();

with FaturaOnly as
(
	select f.ECO_ID idFatura
	from Fatura f
	where f.Data_Teto between @pDTIni and @pDTFim
)
, FaturaWithCounts as 
(
	select x.idFatura, count(distinct pp.Protocolo) QtdeProts, sum(pp.Quantidade) QtdeProcs, sum(pp.Valor_Convenio) Total 
	from FaturaOnly x
	inner join Fatura_Procedimento fp on x.idFatura = fp.Fatura
	inner join Protocolo_Procedimento pp on fp.Protocolo_Procedimento = pp.ECO_ID
	group by x.idFatura
)
select x.idFatura, x.QtdeProts, x.QtdeProcs, x.Total
, f.Data_Teto DataFatura
, f.Numero_Fatura NumeroFatura
, c.Nome Convenio 
, 
(
	f.Numero_Fatura + ' - ' +
	c.Nome + ' - ' + 
	REPLACE(STR(DATEPART(DAY, f.Data_Teto)) + '/' + STR(DATEPART(MONTH, f.Data_Teto)) + '/' + STR(DATEPART(YEAR, f.Data_Teto)),' ','')
	+ ' - Prots(' + REPLACE(STR(x.QtdeProts),' ','') + ') Procs(' +  REPLACE(STR(x.QtdeProcs),' ','') + ')'
) Entidade
from FaturaWithCounts x
inner join Fatura f on x.idFatura = f.ECO_ID
left join Convenio c on f.Convenio = c.ECO_ID
