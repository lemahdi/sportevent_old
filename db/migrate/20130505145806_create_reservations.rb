class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.date :jour
      t.references :creneau, index: true
      t.references :aviron, index: true
      t.boolean :confirmation

      t.timestamps
    end
  end
end
