class AddRememberTokenToRameurs < ActiveRecord::Migration
  def change
  	add_column :rameurs, :remember_token, :string
  	add_index  :rameurs, :remember_token
  end
end
