class AddIndexToRameursEmail < ActiveRecord::Migration
  def change
  	add_index :rameurs, :email, unique: true
  end
end
