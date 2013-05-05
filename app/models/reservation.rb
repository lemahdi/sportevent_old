class Reservation < ActiveRecord::Base
  attr_accessible :jour, :creneau, :aviron, :confirmation
  belongs_to :creneau
  belongs_to :aviron
end
