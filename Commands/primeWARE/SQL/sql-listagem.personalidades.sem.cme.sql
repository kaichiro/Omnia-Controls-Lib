use primeWARE;

with PersonalidadeWithOS_or_FOS as (
	select distinct pers.Nome 
	from TipoMovimentoEstoque tme
	inner join CabecalhoMovimentoEstoque cme on tme.ECO_ID = cme.TipoMovimentoEstoque
	inner join Personalidade pers on cme.Personalidade = pers.ECO_ID	
	where 1 = 1
	and len(replace(pers.Nome, ' ', '')) > 0
)
, PersID as ( 
	select x.Nome from PersonalidadeWithOS_or_FOS x 
)
, PersonalidadesID as ( 
	select pers.Nome from Personalidade pers 
	where len(replace(pers.Nome, ' ', '')) > 0 
	and not exists (select av.ECO_ID from AgenteVenda av where pers.ECO_ID = av.Personalidade)
)
select x.Nome from PersonalidadesID x
where not exists (select y.Nome from PersID y where x.Nome = y.Nome)

use master;
