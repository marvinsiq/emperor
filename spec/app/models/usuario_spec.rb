# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe Usuario do
  context 'Validação de entidades com o Active Record validation' do
    it 'Nome deve estar presente' do
      u = usuario_valido
      u.nome = nil
      u.should_not be_valid

      u.nome = 'nome'
      u.should be_valid
    end

    it 'Nome deve ser único' do
      u = usuario_valido
      u.save
      u2 = usuario_valido
      u2.should_not be_valid
      u.destroy
    end

    it 'Nome deve ter pelo menos 2 caracteres' do
      u = usuario_valido
      u.nome = '1'
      u.should_not be_valid

      u.nome = '12'
      u.should be_valid
    end

    it 'Nome deve ter no máximo 25 caracteres' do
      u = usuario_valido
      u.nome = '01234567890123456789012345'
      u.should_not be_valid

      u.nome = 'nome'
      u.should be_valid
    end

    it 'Senha deve estar presente' do
      u = usuario_valido
      u.senha = nil
      u.should_not be_valid

      u.senha = '12345'
      u.should be_valid
    end

    it 'Senha deve ter pelo menos 5 caracteres' do
      u = usuario_valido
      u.senha = '1234'
      u.should_not be_valid

      u.senha = '12345'
      u.should be_valid
    end

    it 'Senha deve ter no máximo 100 caracteres' do
      u = usuario_valido
      u.senha = '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890'
      u.should_not be_valid

      u.senha = '12345'
      u.should be_valid
    end

    it 'e-mail deve estar presente' do
      u = usuario_valido
      u.email = nil
      u.should_not be_valid

      u.email = 'email@provedor.com'
      u.should be_valid
    end

    it 'e-mail deve ser único' do
      u = usuario_valido
      u.save
      u2 = usuario_valido
      u2.should_not be_valid
      u.destroy
    end

    it 'e-mail deve ter pelo menos 5 caracteres' do
      u = usuario_valido
      u.email = '1@p'
      u.should_not be_valid

      u.email = 'email@provedor.com'
      u.should be_valid
    end

    it 'e-mail deve ter no máximo 100 caracteres' do
      u = usuario_valido
      u.email = '012345678901234567890@12345678901234567890123456789012345678901234567890123456789012345678901234567890'
      u.should_not be_valid

      u.email = 'email@provedor.com'
      u.should be_valid
    end

    it 'Situação deve estar presente' do
      u = usuario_valido
      u.situacao = nil
      u.should_not be_valid

      u.situacao = 'desativado'
      u.should be_valid
    end

    it 'Situação deve ser um dos valores da relação (ativado, desativado, banido)' do
      u = usuario_valido
      u.situacao = 'algo'
      u.should_not be_valid

      u.situacao = 'errado'
      u.should_not be_valid

      u.situacao = 'desativado'
      u.should be_valid

      u.situacao = 'ativado'
      u.should be_valid

      u.situacao = 'banido'
      u.should be_valid
    end

    it 'Código deve estar presente' do
      u = usuario_valido
      u.codigo = nil
      u.should_not be_valid

      u.codigo = 'codigo123'
      u.should be_valid
    end

    it 'Clã deve estar presente' do
      u = usuario_valido
      u.cla = nil
      u.should_not be_valid

      u.cla = Cla.first
      u.should be_valid
    end

    it 'Usuário deve ter pelo menos um perfil atribuído' do
      u = usuario_valido
      u.perfis.clear
      u.should_not be_valid

      u.perfis.push Perfil.first
      u.should be_valid
    end
  end

  context 'Validação de relacionamentos entre entidades' do
    it 'Deve ser possível acessar o clã' do
      Usuario.new.methods.include? :cla
    end

    it 'Deve ser possível relacionar perfis' do
      Usuario.new.methods.include? :perfis
    end
  end

  context 'Validação de callbacks' do
    it 'Senha deve ser criptografada antes do usuário ser criado.' do
      u = usuario_valido
      u.salt.should nil

      u.should_receive(:encrypt_password)
      u.save

      u.salt.should_not nil
    end
  end

  private
    def usuario_valido
      u = Usuario.new :nome => 'Aureliano', :senha => '12345', :senha_confirmation => '12345',
                  :email => 'email@provedor.com', :situacao => 'desativado', :codigo => '45fr4t5n',
                  :cla => Cla.first
      u.perfis.push Perfil.first
      u
    end
end
