use iLabor_VR;

set dateformat ymd;

declare @varDataTeto datetime = '2012-12-31 23:59:59';

with infos1 as
(
	select 
	'Quantidade de protocolos a ser deletado' Label,
	COUNT(p.ECO_ID) Qtde
	from Protocolo p
	where p.Data_Entrada <= @varDataTeto
)
, infos2 as
(
	select 
	'Quantidade de protocolos a ser conservado' Label,
	COUNT(p.ECO_ID) Qtde
	from Protocolo p
	where p.Data_Entrada > @varDataTeto
)
select x.Label, x.Qtde from infos1 x
union all
select x.Label, x.Qtde from infos2 x
union all
select 'TOTAL:', (select x.Qtde from infos1 x) + (select x.Qtde from infos2 x)

select MAX(p.Data_Entrada) from Protocolo p
