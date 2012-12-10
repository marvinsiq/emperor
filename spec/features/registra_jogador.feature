# language: pt

Funcionalidade: Registra um jogador
  Para registrar um jogador
  Como um usuário visitante
  Eu desejo criar uma conta no Emperor

  Cenário: Usuário visitante realiza cadastro no Emperor
    Dado que o usuário 'aureliano' não existe
    Dado que eu acesso a página inicial
    Quando eu clico no link 'Criar conta'
    Então eu devo ver a página de registro de jogador

    Dado que eu preencho o campo 'usuario_nome' com 'aureliano'
    Dado que eu preencho o campo 'usuario_email' com 'teste@provedor.com'
    Dado que eu preencho o campo 'usuario_senha' com '12345'
    Dado que eu preencho o campo 'usuario_senha_confirmation' com '12345'
    Dado que eu seleciono o campo 'usuario_cla_id' com 'Bellatores'
    Dado que eu marco o campo 'concorda_termos'
    Quando eu clico no botão 'Salvar'
    Então eu devo ver a página inicial
    Então eu devo ver a mensagem 'cadastro com sucesso'
