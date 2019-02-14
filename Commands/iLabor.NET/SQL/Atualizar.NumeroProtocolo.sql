/* Comando SQL para atualizar prefixo de N�mero de Protocolo
*  Aten��o: sete apenas o valor para vari�vel @pPrefixo, logo abaixo.
*  ATEN��O: informe o filtro na cl�usula WHERE
* */

/* /// Aqui \\\ */
declare @pPrefixo varchar(4);
set @pPrefixo = '9';
/* \\\ Aqui /// */

set @pPrefixo = rtrim(ltrim(@pPrefixo));
declare @pTamanho int;
set @pTamanho = 9 - len(@pPrefixo);
declare @pLength int;
set @pLength = 1 + len(@pPrefixo);

use iLabor;

update Protocolo
set Numero_Protocolo = 
@pPrefixo + SUBSTRING(Numero_Protocolo, @pLength, @pTamanho)
where (seus filtros)
