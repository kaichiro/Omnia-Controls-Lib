use iLabor;

set dateformat ymd;

declare @pDTIni datetime = '2019-03-10';

select top 5 'Protocolo' Entity, Data_Entrada Data from Protocolo order by Data_Entrada desc;
select top 5 'Auditoria' Entity, Data from Auditoria order by Data desc;

use master;

