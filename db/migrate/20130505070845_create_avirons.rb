class CreateAvirons < ActiveRecord::Migration
  def change
    create_table :avirons do |t|
      t.string :type
      t.integer :nbplaces

      t.timestamps
    end
  end
end
