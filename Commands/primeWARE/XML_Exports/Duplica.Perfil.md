## Instruções para utilizar/importar o arquivo Duplica.Perfil.xml
* Salve este arquivo em um diretório local
* Abra o sistema primeWARE
* Abra o debug ou debugModel
* Copie e cole o comando abaixo, modificando se necessário, o diretório e nome completo do arquivo
  - ('D:\\SistemasOmnia\\primeWARE\\Exports\\'.concat(rtn.Descricao).concat('.xml')).ImportClass(Rotina)
* Escolha a opção (modo) EAL
* Clique no botão Eval (botão que executa o comando OCL)
* Clique no botão Salva DB (persiste a inclusão no banco de dados)