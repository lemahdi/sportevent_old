class Registre < ActiveRecord::Base
  belongs_to :rameur
  belongs_to :reservation

  validates_uniqueness_of [:rameur_id, :reservation_id]
end
