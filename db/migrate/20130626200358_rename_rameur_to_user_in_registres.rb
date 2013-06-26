class RenameRameurToUserInRegistres < ActiveRecord::Migration
  def change
  	remove_index :registres, name: "index_registres_on_rameur_id"
  	rename_column :registres, :rameur_id, :user_id
  	add_index :registres, :user_id
  end
end
