class CreateRameurs < ActiveRecord::Migration
  def change
    create_table :rameurs do |t|
      t.string :nom
      t.string :prenom
      t.string :email

      t.timestamps
    end
  end
end
