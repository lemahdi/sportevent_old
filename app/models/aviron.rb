class Aviron < ActiveRecord::Base
	attr_accessible :description, :nbplaces
	has_many :reservations
end
