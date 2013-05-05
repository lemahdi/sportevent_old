class CreateCreneaus < ActiveRecord::Migration
  def change
    create_table :creneaus do |t|
      t.time :debut
      t.time :fin

      t.timestamps
    end
  end
end
