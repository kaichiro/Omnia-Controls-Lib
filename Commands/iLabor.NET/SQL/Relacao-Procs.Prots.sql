use iLabor;

set dateformat ymd;

declare @pDTIni datetime;
set @pDTIni = getdate() - 30;

declare @pDTFim datetime;
set @pDTFim = getdate();

select @pDTIni, @pDTFim;

with Quantidades as (
	select 'a - Protocolos' Entity, count(p.ECO_ID) Quantidade from Protocolo p where p.Data_Entrada between @pDTIni and @pDTFim
	union all
	select 'b - Procedimentos' Entity, count(pp.ECO_ID) Quantidade from Protocolo_Procedimento pp where pp.Data_Recepcao between @pDTIni and @pDTFim
)
select x.Entity, x.Quantidade from Quantidades x
union 
select 'c - Procs/Prots', (select top 1 x.Quantidade from Quantidades x order by x.Entity desc) / (select top 1 x.Quantidade from Quantidades x order by x.Entity asc)

