use ilabor_SM;

/*
select
pl.Descricao ProcedimentoLaudoDescricao
, p.Descricao ProcedimentoDescricao
, COUNT(pp.ECO_ID) QuantidadeDeProcedimentos
from Procedimento_Laudo pl
left join Procedimento p on pl.Procedimento = p.ECO_ID
inner join Protocolo_Procedimento pp on pl.ECO_ID = pp.Procedimento_Laudo
group by
pl.Descricao 
, p.Descricao 
order by COUNT(pp.ECO_ID) desc
*/

with ProcedimentosTMP as (
  select
  pl.ECO_ID ProcedimentoLaudoID
  , p.ECO_ID ProcedimentoID
  from Procedimento_Laudo pl
  left join Procedimento p on pl.Procedimento = p.ECO_ID
)
, Procedimentos1TMP as (
  select
  x.ProcedimentoID
  , x.ProcedimentoLaudoID
  , COUNT(pp.ECO_ID) QuantidadeDeProtocoloProcedimento
  from ProcedimentosTMP x
  inner join Protocolo_Procedimento pp on x.ProcedimentoLaudoID = pp.Procedimento_Laudo
  group by
  x.ProcedimentoID
  , x.ProcedimentoLaudoID
)
  select
  x.QuantidadeDeProtocoloProcedimento
  , pl.Descricao ProcedimentoLaudo
  , p.Descricao Procedimento
  from Procedimentos1TMP x
  left join Procedimento_Laudo pl on x.ProcedimentoLaudoID = pl.ECO_ID
  left join Procedimento p on x.ProcedimentoID = p.ECO_ID
  order by x.QuantidadeDeProtocoloProcedimento desc


