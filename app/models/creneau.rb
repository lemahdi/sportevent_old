class Creneau < ActiveRecord::Base
	attr_accessible :debut, :fin
	has_many :reservations

  scope :asc, -> attr { order("creneaus.#{attr} ASC") }
end
