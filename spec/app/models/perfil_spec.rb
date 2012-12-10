# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe Perfil do
  context 'Validação de entidades com o Active Record validation' do
    it 'Nome deve estar presente' do
      p = Perfil.new :descricao => 'descrição do perfil.'
      p.should_not be_valid

      p.nome = 'nome'
      p.should be_valid
    end

    it 'Nome deve ser único' do
      p = Perfil.new :nome => Perfil.first.nome, :descricao => 'descrição do perfil'
      p.should_not be_valid
    end

    it 'Nome deve ter pelo menos 3 caracteres' do
      p = Perfil.new :nome => '12', :descricao => 'descrição do perfil'
      p.should_not be_valid

      p.nome = '123'
      p.should be_valid
    end

    it 'Nome deve ter no máximo 50 caracteres' do
      p = Perfil.new :nome => '012345678901234567890123456789012345678901234567890', :descricao => 'descrição do perfil'
      p.should_not be_valid

      p.nome = 'nome'
      p.should be_valid
    end

    it 'Descrição deve estar presente' do
      p = Perfil.new :nome => 'Nome'
      p.should_not be_valid

      p.descricao = 'descrição'
      p.should be_valid
    end

    it 'Descrição deve ter pelo menos 5 caracteres' do
      p = Perfil.new :nome => 'Nome', :descricao => '1234'
      p.should_not be_valid

      p.descricao = '12345'
      p.should be_valid
    end

    it 'Descrição deve ter no máximo 100 caracteres' do
      p = Perfil.new :nome => 'Nome', :descricao => '01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567891'
      p.should_not be_valid

      p.descricao = 'descrição válida'
      p.should be_valid
    end
  end

  context 'Validação de relacionamentos entre entidades' do
    it 'Deve ser possível relacionar 0 ou muitos usuários' do
      Perfil.new.methods.include?(:usuarios).should eq(true)
    end
  end
end
