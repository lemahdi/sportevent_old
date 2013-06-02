class RemovePasswordDigestFromRameur < ActiveRecord::Migration
  def change
  	remove_column :rameurs, :password_digest
  end
end
