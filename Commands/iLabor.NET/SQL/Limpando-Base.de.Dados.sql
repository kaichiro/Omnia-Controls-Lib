/** Setando a base de dados */
use iLaborNEW;

/** Selecionando tabelas a serem truncadas/limpadas */
/** Selecionar e executar o resultado desta consulta */
select 'truncate table ' + so.name +';'
from SysObjects so 
where so.type = 'u' 
and not so.name like 'ECO%'
and not so.name in ('dtproperties', 'sysdiagrams')
order by so.name;

/** Tabela que não será truncada, apenas atualizada */
update ECO_ID set BOLD_ID = 0;

