use iLabor;

set dateformat ymd;

declare @pFatura int;

set @pFatura = (select top 1 f.ECO_ID from Fatura f);

select
fp.Fatura FaturaID
, fp.Baixa DataBaixa
, fp.Tipo
, fp.Valor
, fp.Vencimento
from Fatura_Parcelamento fp 
where fp.Fatura = @pFatura