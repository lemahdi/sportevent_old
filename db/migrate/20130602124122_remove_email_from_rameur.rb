class RemoveEmailFromRameur < ActiveRecord::Migration
  def change
  	remove_column :rameurs, :email
  end
end
