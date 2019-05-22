use iLabor;

declare @MedicoID_origem int = 20658191;
declare @MedicoID_destino int = 17395637;

update Protocolo 
	set Medico = @MedicoID_destino 
	where Medico = @MedicoID_origem;

update Protocolo_ProcedimentoProtocolo_ProcedimentosMedicoMedicos 
	set Medicos = @MedicoID_destino 
	where Medicos = @MedicoID_origem;

delete from Medico where ECO_ID = @MedicoID_origem;
