/** Setando a base de dados */
use iLaborNEW;

/** Selecionando tabelas a serem truncadas/limpadas */
/** Selecionar e executar o resultado desta consulta */
select 'truncate table ' + so.name +';'
from SysObjects so 
where so.type = 'u' 
and not so.name like 'ECO%'
and not so.name in ('dtproperties', 'sysdiagrams', 'Usuario')
order by so.name;

/** Setando para sequenciador */
update ECO_ID set BOLD_ID = 3;

/** Deletando usuários, exceto Admin e Administração */
delete from Usuario where not Nome in ('Admin', 'administracao');

/** Setando ID para Perfil/Grupo */
update Usuario set ECO_ID = 1 where Nome = 'administracao';

/** Setado ID e Grupo para usuário Admin */
update Usuario set ECO_ID = 2, Grupo = 1 where Nome = 'Admin';

/** Limpando a tabela de IDs */
truncate table ECOModelRoot;

