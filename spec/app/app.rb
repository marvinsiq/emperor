#encoding: utf-8

class Emperor < Padrino::Application
  register SassInitializer
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers

  enable :sessions

  get :index do
    render 'index'
  end

  put :login do
    usuario = Usuario.where(:nome => params['usuario']).first
    if !usuario
      params['login_mensagem_erro'] = "Usuário \"#{params['usuario']}\" não existe."
      render 'index'
    else
      if usuario.situacao == Usuario.ATIVADO
        u = Usuario.new :nome => params['usuario'], :senha => params['senha'], :salt => usuario.salt
        u.encrypt_password

        if usuario.senha != u.senha
          params['login_mensagem_erro'] = "Senha errada."
          render 'index'
        else
          "Página inicial do Império do Mal. Em construção!"
        end
      else
        params['login_mensagem_erro'] = "Usuário desativado não pode efetuar login."
        render 'index'
      end
    end
  end

  get :guia do
    'Guia do jogo'
  end

  get :sobre do
    render 'sobre'
  end

  # Configurando mailer.
  set :delivery_method, :smtp => { 
    :address              => "smtp.gmail.com",
    :port                 => 587,
    :user_name            => 'emperor.imperio.mal@gmail.com',
    :password             => 'imperiomal',
    :authentication       => :plain,
    :enable_starttls_auto => true  
  }

  ##
  # Caching support
  #
  # register Padrino::Cache
  # enable :caching
  #
  # You can customize caching store engines:
  #
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Memcached.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Memcache.new(::Dalli::Client.new('127.0.0.1:11211', :exception_retry_limit => 1))
  #   set :cache, Padrino::Cache::Store::Redis.new(::Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0))
  #   set :cache, Padrino::Cache::Store::Memory.new(50)
  #   set :cache, Padrino::Cache::Store::File.new(Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
  #

  ##
  # Application configuration options
  #
  # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
  # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
  # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
  # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
  # set :public_folder, "foo/bar" # Location for static assets (default root/public)
  # set :reload, false            # Reload application files (default in development)
  # set :default_builder, "foo"   # Set a custom form builder (default 'StandardFormBuilder')
  # set :locale_path, "bar"       # Set path for I18n translations (default your_app/locales)
  # disable :sessions             # Disabled sessions by default (enable if needed)
  # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
  # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
  #

  ##
  # You can configure for a specified environment like:
  #
  #   configure :development do
  #     set :foo, :bar
  #     disable :asset_stamp # no asset timestamping for dev
  #   end
  #

  ##
  # You can manage errors like:
  #
  #   error 404 do
  #     render 'errors/404'
  #   end
  #
  #   error 505 do
  #     render 'errors/505'
  #   end
  #
end
