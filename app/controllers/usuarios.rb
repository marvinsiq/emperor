#encoding: utf-8

Emperor.controllers :usuarios do
  
  get :novo do
    render 'usuarios/novo'
  end

  post :cria do    
    @usuario = Usuario.new params['usuario']
    @usuario.codigo = gera_codigo_ativacao
    @usuario.situacao = Usuario.DESATIVADO
    @usuario.perfis << Perfil.where(:nome => 'Jogador').first

    if @usuario.valid?
      if !params['concorda_termos']
        @usuario.errors.add :termos, '- Para criar um usuário é necessário concordar com os termos e condiçõs de uso.'
        @usuario.senha = @usuario.senha_confirmation = nil
        render 'usuarios/novo'
      else
        if @usuario.save
          flash[:notice] = 'Usuário criado com sucesso. Verifique sua caixa de e-mail e siga as instruções para ativar sua conta.'
          deliver :registro, :novo_jogador_email, @usuario, request.host_with_port
          redirect url(:index)
        else
          @usuario.senha = @usuario.senha_confirmation = nil
          render 'usuarios/novo'
        end
      end
    else
      @usuario.senha = @usuario.senha_confirmation = nil
      render 'usuarios/novo'
    end
  end

  get :ativa, :map => 'usuarios/novo/jogador', :with => [:id, :codigo] do
    @usuario = Usuario.find params[:id]
    if @usuario.codigo != params[:codigo]
      flash[:error] = 'Código de ativação inválido!'
      redirect url(:index)
      return
    end

    @usuario.situacao = Usuario.ATIVADO
    @usuario.senha_confirmation = @usuario.senha

    if @usuario.save
      flash[:notice] = "O jogador <u>#{@usuario.nome}</u> foi ativado e está ápto a participar do Império do Mal. Efetue login para iniciar."
    else
      flash[:error] = "Ocorreu um erro ao tentar ativar usuário. Tente novamente mais tarde."
    end

    deliver :registro, :ativa_jogador_email, @usuario, request.host_with_port
    redirect url(:index)
  end

  get :recupera_senha do
    if params['email'] == 'none'
      params['email'] = ''
    end

    render 'usuarios/solicita_nova_senha'
  end

  put :gera_nova_senha do
    @usuario = Usuario.where(:email => params[:email]).first
    if @usuario.nil?
      params['mensagem_erro'] = "Não existe usuário cadastrado com o e-mail #{params['email']}"
      render 'usuarios/solicita_nova_senha'
    else
      nova_senha = gera_codigo_ativacao 8
      @usuario.codigo = gera_codigo_ativacao
      @usuario.senha = nova_senha
      @usuario.encrypt_password
      @usuario.senha_confirmation = @usuario.senha

      if @usuario.save
        flash[:notice] = 'Uma nova senha foi criada e enviada por e-mail.'
        deliver :registro, :recupera_senha_email, @usuario, nova_senha, request.host_with_port
      else
        flash[:error] = 'Não foi possível processar o pedido de troca de senha. Tente novamente mais tarde.'
      end

      redirect url(:index)
    end
  end

end
