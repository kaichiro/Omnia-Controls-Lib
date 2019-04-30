/**
 * SQL Statement
 * Author: Kaichiro Fukuda
 * Description: atualizar campo Id_Paciente da tabela Paciente, incrementando valor 
 *              num�rico inteiro para este mesmo campo a partir de um determinado 
 *              n�mero inicial
 */

-- setando base de dados
use iLabor;

-- declarando vari�veis auxiliares
declare @eco int;
declare @id int;
set @id = 0;

-- declarando vari�vel e atribuindo valor para CURSOR 
declare PacienteCRS CURSOR FOR select pac.ECO_ID from Paciente pac order by pac.Nome;
-- abrindo vari�vel CURSOR
OPEN PacienteCRS;
-- setando valor incial para vari�vel auxiliar a partir de CURSOR
FETCH NEXT FROM PacienteCRS INTO @eco;
-- looping para vari�vel CURSOR (condi��o: enquanto existir registro em vari�vel CURSOR
WHILE @@FETCH_STATUS = 0
BEGIN
	-- incrementa vari�vel auxiliar
	set @id = @id + 1;
	-- atualiza campo Id_Paciente da tabela Paciente
	update Paciente set Id_Paciente = @id where ECO_ID =  @eco;
	-- caminha ao pr�ximo registro do CURSOR e atribui valor para vari�vel auxiliar
	FETCH NEXT FROM PacienteCRS INTO @eco;
END
-- fechar vari�vel CURSOR
CLOSE PacienteCRS;
-- encerra vari�vel CURSOR
DEALLOCATE PacienteCRS;

-- atualizar registro de numerador para a tabela Paciente
update Numerador set UltimoNumero = @id + 1 where Mnemonico = 'PACIENTE';

