use iLabor;

select *
from Numerador n
where n.Mnemonico = 'PACIENTE'
order by n.Mnemonico;

select p.ECO_ID, p.Nome, p.Id_Paciente from Paciente p order by p.Nome;

