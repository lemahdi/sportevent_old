class RemoveAdminFromRameur < ActiveRecord::Migration
  def change
  	remove_column :rameurs, :admin
  end
end
