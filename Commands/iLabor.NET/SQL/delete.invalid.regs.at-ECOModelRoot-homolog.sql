/****** Object:  UDF    Script Date: 03/11/2019 09:08:07 ******/
-- =============================================
-- Author:		Kaichiro Fukuda
-- Create date: 03/11/2019 09:08:07
-- Description:	script for database integrity approval, based on protocol processing test
-- =============================================

/*
Result - Description
OK     - Crie um protocolo e o processei
*/

-- setando base de dados
use iLaborTeste2;

-- configurando máscara/padrão/format DateTime
set dateformat ymd;

-- variáveis para consultas de protocolos
declare @pDTIni1 datetime = '2018-12-01';
declare @pDTIni2 datetime = '2019-01-01';
declare @pDTIni3 datetime = '2019-02-01';

-- criando tabela temporária para acumular protocolos a serem pesquisados (antes de criar a tabela temporária, é verificado se a mesma existe, se sim, ela é excluída)
if exists(select * from tempdb.dbo.sysobjects o where o.name like '#Prots%') drop table #Prots;
    create table #Prots (Numero_Protocolo varchar(16), Data_Entrada datetime);

-- inserindo primeiros registros de protocolos na tabela temporária
insert into #Prots
	select top 3 p.Numero_Protocolo, p.Data_Entrada 
    from Protocolo p 
    order by p.Data_Entrada asc;

-- inserindo registros de protocolos (após um perído determinado pelo parâmetro) na tabela temporária
insert into #Prots
	select top 2 p.Numero_Protocolo, p.Data_Entrada 
    from Protocolo p 
    where p.Data_Entrada >= @pDTIni1 
    order by p.Data_Entrada asc;

-- inserindo registros de protocolos (após um perído determinado pelo parâmetro) na tabela temporária
insert into #Prots
	select top 2 p.Numero_Protocolo, p.Data_Entrada 
    from Protocolo p 
    where p.Data_Entrada >= @pDTIni2 
    order by p.Data_Entrada asc;

-- inserindo registros de protocolos (após um perído determinado pelo parâmetro) na tabela temporária
insert into #Prots
	select top 2 p.Numero_Protocolo, p.Data_Entrada 
    from Protocolo p 
    where p.Data_Entrada >= @pDTIni3 
    order by p.Data_Entrada asc;

-- inserindo registros de protocolos (após um perído determinado pelo parâmetro) na tabela temporária
insert into #Prots
	select top 5 p.Numero_Protocolo, p.Data_Entrada 
    from Protocolo p 
    order by p.Data_Entrada desc;

-- mostrando conteúdo da tabela temporária (relação de protocolos a serem testados/homologados)
select x.Numero_Protocolo, x.Data_Entrada 
from #Prots x;



/*
Query result
Protocolo 	Data
000001/18 	2018-10-01 07:10:26.690
000002/18 	2018-10-01 07:13:41.870
000003/18 	2018-10-01 07:18:07.423
007387/18 	2018-12-03 07:44:45.013
007388/18 	2018-12-03 08:07:29.660
000001/19 	2019-01-02 05:36:29.190
000002/19 	2019-01-02 06:51:44.020
003986/19 	2019-02-01 06:07:36.680
003989/19 	2019-02-01 06:10:21.193
007737/19 	2019-03-11 08:27:20.650
007736/19 	2019-02-26 15:56:29.850
007735/19 	2019-02-26 14:38:25.087
007734/19 	2019-02-26 12:06:22.087
007733/19 	2019-02-26 12:05:31.390
*/

