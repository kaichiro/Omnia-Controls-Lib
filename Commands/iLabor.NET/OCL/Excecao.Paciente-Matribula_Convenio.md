#### Exceção para Matricula_Convenio em cadasatro de paciente

Comando OCL:

```sh
('Paciente.allInstances->select( pac | (pac.Matricula_Convenio = \'' + self->first.Matricula_Convenio + '\') and (pac.Matricula_Convenio <> \'\') )')
.EnsureObjects(Paciente)->excluding(self->first)
->notEmpty
```

Instruções:
 * criar uma exceção do tipo **ExcecaoPaciente**;
 * no campo **Comando**, colar o *Comando OCL* que está escrito logo acima;
 * nos campos **Nome** e **Layout**, colocar o seguinte texto: *Matrícula convênio duplicada!* (sugestão)
