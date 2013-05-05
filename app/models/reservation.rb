class Reservation < ActiveRecord::Base
  belongs_to :creaneau
  belongs_to :aviron
end
