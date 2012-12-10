class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :nome
      t.string :email
      t.string :senha
      t.string :situacao
      t.string :codigo
      t.integer :cla_id
      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
