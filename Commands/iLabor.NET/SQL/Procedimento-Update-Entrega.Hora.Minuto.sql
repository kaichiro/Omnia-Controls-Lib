/** 
* Author: Kaichiro Fukuda
*/

/* Choice the database */
use iLabor;

select
ECO_ID
, Mnemonico
, Descricao
, Entrega_Hora
, Entrega_Minuto
from Procedimento;

/* Updating tuplas */
update Procedimento set Entrega_Hora = 16, Entrega_Minuto = 0;

select
ECO_ID
, Mnemonico
, Descricao
, Entrega_Hora
, Entrega_Minuto
from Procedimento;
