class AddResponsableToReservations < ActiveRecord::Migration
  def change
    add_reference :reservations, :responsable, index: true
  end
end
