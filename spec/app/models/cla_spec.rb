# encoding: utf-8

require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper.rb')

describe Cla do
  context 'Validação de entidades com o Active Record validation' do
    it 'Nome deve estar presente' do
      c = Cla.new :descricao => 'descrição do clã.'
      c.should_not be_valid

      c.nome = 'nome'
      c.should be_valid
    end

    it 'Nome deve ser único' do
      c = Cla.new :nome => Cla.first.nome, :descricao => 'descrição do clã'
      c.should_not be_valid
    end

    it 'Nome deve ter pelo menos 3 caracteres' do
      c = Cla.new :nome => '12', :descricao => 'descrição do clã'
      c.should_not be_valid

      c.nome = 123.to_s
      c.should be_valid
    end

    it 'Nome deve ter no máximo 50 caracteres' do
      c = Cla.new :nome => '012345678901234567890123456789012345678901234567890', :descricao => 'descrição do clã'
      c.should_not be_valid

      c.nome = 'nome'
      c.should be_valid
    end

    it 'Descrição deve estar presente' do
      c = Cla.new :nome => 'Nome'
      c.should_not be_valid

      c.descricao = 'descrição'
      c.should be_valid
    end

    it 'Descrição deve ter pelo menos 5 caracteres' do
      c = Cla.new :nome => 'Nome', :descricao => '1234'
      c.should_not be_valid

      c.descricao = '12345'
      c.should be_valid
    end

    it 'Descrição deve ter no máximo 200 caracteres' do
      c = Cla.new :nome => 'Nome', :descricao => '012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567891'
      c.should_not be_valid

      c.descricao = 'descrição válida'
      c.should be_valid
    end
  end

  context 'Validação de relacionamentos entre entidades' do
    it 'Deve ser possível relacionar 0 ou muitos usuários' do
      Cla.new.methods.include?(:usuarios).should eq(true)
    end
  end
end
