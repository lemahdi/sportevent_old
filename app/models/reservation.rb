class Reservation < ActiveRecord::Base
  belongs_to :creneau
  belongs_to :aviron
end
