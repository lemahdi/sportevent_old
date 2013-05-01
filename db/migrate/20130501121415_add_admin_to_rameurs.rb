class AddAdminToRameurs < ActiveRecord::Migration
  def change
    add_column :rameurs, :admin, :boolean, default: false
  end
end
