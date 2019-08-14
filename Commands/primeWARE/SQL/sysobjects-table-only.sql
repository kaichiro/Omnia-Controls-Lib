use primeWARE;

select
'--truncate table ' + so.name
from SysObjects so
where so.type = 'u'
order by so.name
