class AddPasswordDigestToRameurs < ActiveRecord::Migration
  def change
    add_column :rameurs, :password_digest, :string
  end
end
