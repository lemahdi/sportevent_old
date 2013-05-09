class Registre < ActiveRecord::Base
  belongs_to :rameur
  belongs_to :reservation
end
