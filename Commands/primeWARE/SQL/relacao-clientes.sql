use primeWAREFIN;

declare @pTpContrato uniqueidentifier = (select top 1 tpCntr.ECO_ID from TipoContrato tpCntr where tpCntr.Descricao = 'primeWARE - ERP Comercial');

with Infos010 as (
	select distinct
	cntr.State
	, pers.Nome
	, pj.NomeFantasia
	,
	replace(
	rtrim( 
	coalesce( (
		select distinct fone.Numero + '     ' 
		from Endereco ender
		inner join Telefone fone on ender.ECO_ID = fone.Endereco
		where ender.Personalidade = pers.ECO_ID and fone.Numero <> '' 
		for xml path(''), type).value('.[1]','varchar(max)') 
	, '') 
	)
	, '     ', ', ')
	Telefones
	,
	replace(
	rtrim( 
	coalesce( (
		select distinct ender.EMail + '     ' 
		from Endereco ender
		where ender.Personalidade = pers.ECO_ID and ender.EMail <> '' 
		for xml path(''), type).value('.[1]','varchar(max)') 
	, '') 
	)
	, '     ', ', ')
	EMail
	from Contrato cntr 
	inner join Personalidade pers on cntr.Cliente = pers.Cliente
	left join PessoaJuridica pj on pers.ECO_ID = pj.ECO_ID
	where cntr.TipoContrato = @pTpContrato
)
	select
	x.State
	, x.Nome
	, x.NomeFantasia
	, x.Telefones
	, x.EMail
	from Infos010 x
	order by 
	x.State
	, x.Nome
	, x.NomeFantasia

