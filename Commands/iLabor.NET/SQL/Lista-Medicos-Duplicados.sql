use iLabor;

select m.CRM, m.Nome, count(m.Nome + m.CRM)
from Medico m
group by m.CRM, m.Nome
having count(m.Nome + m.CRM) > 1
order by count(m.Nome + m.CRM) desc;

