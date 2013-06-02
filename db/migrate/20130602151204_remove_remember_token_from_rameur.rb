class RemoveRememberTokenFromRameur < ActiveRecord::Migration
  def change
  	remove_index :rameurs, :remember_token
  	remove_column :rameurs, :remember_token
  end
end
