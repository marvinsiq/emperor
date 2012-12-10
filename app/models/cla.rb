class Cla < ActiveRecord::Base
  validates :nome, :presence => true, :uniqueness => true, :length => {:minimum => 3, :maximum => 50}
  validates :descricao, :presence => true, :length => {:minimum => 5, :maximum => 200}

  has_many :usuarios

  def to_s
    nome
  end
end
