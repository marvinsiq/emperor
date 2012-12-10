class Perfil < ActiveRecord::Base
  validates :nome, :presence => true, :uniqueness => true, :length => {:minimum => 3, :maximum => 50}
  validates :descricao, :presence => true, :length => {:minimum => 5, :maximum => 100}

  has_and_belongs_to_many :usuarios

  def to_s
    nome
  end
end
