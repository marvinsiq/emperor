# language: pt

Funcionalidade: Página inicial
  Para garantir que a página inicial foi desenhada corretamente
  Como um usuário visitante
  Eu desejo conhecer o sítio

  Cenário: Usuário visitante acessa página inicial
    Quando eu acesso a página inicial do Emperor
    Então eu devo ver o campo 'usuario'
    E eu devo ver o campo 'senha'
    E eu devo ver o link 'Esqueceu sua senha?'
    E eu devo ver o link 'Criar conta'
    E eu devo ver o link 'Guia do jogo'
    E eu devo ver o link 'Sobre'
    E eu devo ver o botão 'Login'
