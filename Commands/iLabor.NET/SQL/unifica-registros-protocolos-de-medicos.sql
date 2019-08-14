use iLabor_SM;

set dateformat ymd;

declare @IdMedicoOrigem int = 1;
declare @IdMedicoDestino int = 10;


-- update Protocolo set Medico = @IdMedicoDestino where Medico = @IdMedicoOrigem;

-- update Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos set Medicos = @IdMedicoDestino where Medicos = @IdMedicoOrigem;


select md.ECO_ID
, md.Nome
, COUNT(ppm.ECO_ID)
from Medico md
inner join Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppm on md.ECO_ID = ppm.Medicos
group by 
md.ECO_ID
, md.Nome
order by COUNT(ppm.ECO_ID) desc, md.Nome, md.ECO_ID
