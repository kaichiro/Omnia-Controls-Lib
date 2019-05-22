/* Individualizando/isolando estidade Médico */

declare @pCRM varchar(16) = '52158907';
declare @pNome varchar(128) = 'AODO LAINETT';
declare @pSigla_Conselho varchar(16) = 'CRM';
declare @pUF_Conselho varchar(8) = '';


use iLabor;

select 
md.ECO_ID
, md.Id_Importado
, md.CRM
, md.Nome
, md.Sigla_Conselho
, md.UF_Conselho
, (select COUNT(p.ECO_ID) from Protocolo p where md.ECO_ID = p.Medico) QuantidadeProtocolos
, (select COUNT(pp.ECO_ID) from Protocolo_Procedimento pp inner join Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos ppm on pp.ECO_ID = ppm.Protocolo_Procedimentos where md.ECO_ID = ppm.Medicos) QuantidadeProtocolos
from Medico md
where md.CRM = @pCRM
and md.Nome = @pNome
and md.Sigla_Conselho = @pSigla_Conselho
and md.UF_Conselho = @pUF_Conselho
order by 7 desc, 8 desc;
