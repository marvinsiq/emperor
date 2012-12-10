class CreatePerfisUsuariosJoinTable < ActiveRecord::Migration
  def self.up
    create_table :perfis_usuarios, :id => false do |t|
      t.integer :perfil_id
      t.integer :usuario_id
    end
  end

  def self.down
    drop_table :perfis_usuarios
  end
end
