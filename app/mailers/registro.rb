##
# Mailer methods can be defined using the simple format:
#
# email :registration_email do |name, user|
#   from 'admin@site.com'
#   to   user.email
#   subject 'Welcome to the site!'
#   locals  :name => name
#   content_type 'text/html'       # optional, defaults to plain/text
#   via     :sendmail              # optional, to smtp if defined, otherwise sendmail
#   render  'registration_email'
# end
#
# You can set the default delivery settings from your app through:
#
#   set :delivery_method, :smtp => {
#     :address         => 'smtp.yourserver.com',
#     :port            => '25',
#     :user_name       => 'user',
#     :password        => 'pass',
#     :authentication  => :plain, # :plain, :login, :cram_md5, no auth by default
#     :domain          => "localhost.localdomain" # the HELO domain provided by the client to the server
#   }
#
# or sendmail (default):
#
#   set :delivery_method, :sendmail
#
# or for tests:
#
#   set :delivery_method, :test
#
# and then all delivered mail will use these settings unless otherwise specified.
#

#encoding: utf-8

Emperor.mailer :registro do

  defaults :content_type => 'html'

  email :novo_jogador_email do |usuario, dominio|
    from         'emperor.imperio.mal@gmail.com'
    to           usuario.email
    locals       :usuario => usuario, :dominio => dominio
    content_type :html
    subject      'Imperio do Mal: registro de usuario' # Mesmo utilizando o comentário mágico de encoding não foi possível colocar texto com acentos dentro deste método.
    render       'novo_jogador'
  end

  email :ativa_jogador_email do |usuario, dominio|
    from         'emperor.imperio.mal@gmail.com'
    to           usuario.email
    locals       :usuario => usuario, :dominio => dominio
    content_type :html
    subject      'Bem vindo ao Imperio do Mal'
    render       'ativa_jogador'
  end

  email :recupera_senha_email do |usuario, nova_senha, dominio|
    from         'emperor.imperio.mal@gmail.com'
    to           usuario.email
    locals       :usuario => usuario, :nova_senha => nova_senha, :dominio => dominio
    content_type :html
    subject      'Imperio do Mal: nova senha'
    render       'recupera_senha'
  end

end
