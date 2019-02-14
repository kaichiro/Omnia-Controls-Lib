/* Comando SQL para atualizar prefixo de Número de Protocolo
*  Atenção: sete apenas o valor para variável @pPrefixo, logo abaixo.
*  ATENÇÃO: informe o filtro na cláusula WHERE
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
