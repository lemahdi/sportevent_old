class Aviron < ActiveRecord::Base
	attr_accessible :description, :nbplaces
	has_many :reservations

  scope :asc, -> attr { order("avirons.#{attr} ASC") }
end
