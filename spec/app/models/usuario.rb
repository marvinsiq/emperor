# encoding: utf-8

require 'bcrypt'

class Usuario < ActiveRecord::Base
  include BCrypt

  validates :nome, :presence => true, :uniqueness => true, :length => {:minimum => 2, :maximum => 25}
  validates :senha, :presence => true, :confirmation => true, :length => {:minimum => 5, :maximum => 100}
  validates :senha_confirmation, :presence => true
  validates :email, :presence => true, :uniqueness => true, :length => {:minimum => 5, :maximum => 100}
  validates :situacao, :presence => true, :inclusion => {:in => %w(ativado desativado banido)}
  validates :codigo, :presence => true
  validates :cla, :presence => true
  validates_associated :perfis
  validates_associated :cla
  validate :usuario_deve_ter_pelo_menos_um_perfil

  belongs_to :cla
  has_and_belongs_to_many :perfis

  before_create :encrypt_password

  def Usuario.ATIVADO
    'ativado'
  end

  def Usuario.DESATIVADO
    'desativado'
  end

  def Usuario.BANIDO
    'banido'
  end

  def encrypt_password
    if self.senha
      if !self.senha.empty?
        if !self.salt or self.salt.empty?
          self.salt = Engine.generate_salt
        end

        write_attribute(:senha, Engine.hash_secret(self.senha, self.salt))
        write_attribute(:salt, self.salt)
      end
    end
  end

  def usuario_deve_ter_pelo_menos_um_perfil
    errors.add(:perfil, 'Usuário deve ter pelo menos um perfil.') unless perfis.size > 0
  end
end
