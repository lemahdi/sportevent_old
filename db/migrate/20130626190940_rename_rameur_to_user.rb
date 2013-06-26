class RenameRameurToUser < ActiveRecord::Migration
  def change
  	rename_table :rameurs, :users
  end
end
