use iLabor;

/* declarando e atribuindo valor */
declare @Tubo int = (select top 1 ECO_ID from tubo where Descricao = 'SEM TUBO');

update Procedimento set Tubo = @Tubo where Tubo is null;

use master;

