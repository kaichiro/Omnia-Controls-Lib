select
case 
  when pj.ECO_ID is not null then 'PJ'
  when pf.ECO_ID is not null then 'PF'
  else 'Personalidade'
end TipoPersonalidade
, pers.Nome
, pj.NomeFantasia
,
replace(
rtrim( 
coalesce( (
select fone.Numero + '     ' 
from Endereco ender
	inner join Telefone fone on ender.ECO_ID = fone.Endereco
	where ender.Personalidade = pers.ECO_ID and fone.Numero <> '' 
	order by fone.Numero 
	for xml path(''), type).value('.[1]','varchar(max)') 
, '') 
)
, '     ', ', ')
Telefones
,
replace(
rtrim( 
coalesce( (
select ender.Email + '     ' 
from Endereco ender
	where ender.Personalidade = pers.ECO_ID 
	order by ender.Email
	for xml path(''), type).value('.[1]','varchar(max)') 
, '') 
)
, '     ', ', ')
EMails
from Personalidade pers
left join PessoaFisica pf on pers.ECO_ID = pf.ECO_ID
left join PessoaJuridica pj on pers.ECO_ID = pj.ECO_ID
order by pers.Nome

