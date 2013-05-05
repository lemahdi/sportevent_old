class RenameTypeToDescription < ActiveRecord::Migration
  def change
  	rename_column :avirons, :type, :description
  end
end
