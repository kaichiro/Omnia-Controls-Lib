with infos as (
	SELECT OBJECT_NAME(si.ID) As Tabela, si.Rows As Linhas 
	FROM sysindexes si	
	WHERE IndID IN (0,1)
)
select x.*
from infos x
where not x.Tabela like 'MS%'
and not x.Tabela like 'sys%'
and not x.Tabela like 'queue%'
and not x.Tabela like 'filestr%'
ORDER BY x.Linhas DESC

