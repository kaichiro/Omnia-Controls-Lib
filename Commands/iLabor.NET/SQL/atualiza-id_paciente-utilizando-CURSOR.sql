/**
 * SQL Statement
 * Author: Kaichiro Fukuda
 * Description: atualizar campo Id_Paciente da tabela Paciente, incrementando valor 
 *              numérico inteiro para este mesmo campo a partir de um determinado 
 *              número inicial
 */

-- setando base de dados
use iLabor;

-- declarando variáveis auxiliares
declare @eco int;
declare @id int;
set @id = 0;

-- declarando variável e atribuindo valor para CURSOR 
declare PacienteCRS CURSOR FOR select pac.ECO_ID from Paciente pac order by pac.Nome;
-- abrindo variável CURSOR
OPEN PacienteCRS;
-- setando valor incial para variável auxiliar a partir de CURSOR
FETCH NEXT FROM PacienteCRS INTO @eco;
-- looping para variável CURSOR (condição: enquanto existir registro em variável CURSOR
WHILE @@FETCH_STATUS = 0
BEGIN
	-- incrementa variável auxiliar
	set @id = @id + 1;
	-- atualiza campo Id_Paciente da tabela Paciente
	update Paciente set Id_Paciente = @id where ECO_ID =  @eco;
	-- caminha ao próximo registro do CURSOR e atribui valor para variável auxiliar
	FETCH NEXT FROM PacienteCRS INTO @eco;
END
-- fechar variável CURSOR
CLOSE PacienteCRS;
-- encerra variável CURSOR
DEALLOCATE PacienteCRS;

-- atualizar registro de numerador para a tabela Paciente
update Numerador set UltimoNumero = @id + 1 where Mnemonico = 'PACIENTE';

