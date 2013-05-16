class Registre < ActiveRecord::Base
  belongs_to :rameur
  belongs_to :reservation

  validates_uniqueness_of :rameur_id, scope: :reservation_id
end
