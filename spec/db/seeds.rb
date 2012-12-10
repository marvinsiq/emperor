#encoding: utf-8

shell.say 'SEED: db/seeds.rb'
shell.say 'Carregando dados iniciais do banco de dados.'
shell.say ''
shell.say 'Criando perfis:'

shell.say '  -Administrador'
Perfil.create(
  :nome => 'Administrador',
  :descricao => 'Papel com privilégios administrativos.'
)

shell.say '  -Jogador'
Perfil.create(
  :nome => 'Jogador',
  :descricao => 'Permite executar tarefas referentes ao jogo.'
)

shell.say ''
shell.say 'Criando clãs:'

shell.say '  -Bellatores'
Cla.create(
  :nome => 'Bellatores',
  :descricao => 'Tribo de guerreiros. Especialidade: guerra.'
)

shell.say '  -Aedificantes'
Cla.create(
  :nome => 'Aedificantes',
  :descricao => 'Tribo de construtores. Especialidade: engenharia.'
)

shell.say '  -Mercatores'
Cla.create(
  :nome => 'Mercatores',
  :descricao => 'Tribo de negociadores. Especialidade: comércio.'
)

shell.say ''
shell.say 'Fim'
