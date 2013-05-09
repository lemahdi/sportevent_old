class CreateRegistres < ActiveRecord::Migration
  def change
    create_table :registres do |t|
      t.references :rameur, index: true
      t.references :reservation, index: true

      t.timestamps
    end
  end
end
