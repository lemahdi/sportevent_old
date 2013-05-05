class Creneau < ActiveRecord::Base
	attr_accessible :debut, :fin
	has_many :reservations
end
