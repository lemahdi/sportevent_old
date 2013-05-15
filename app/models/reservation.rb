class Reservation < ActiveRecord::Base
  attr_accessible :jour, :creneau_id, :aviron_id, :confirmation

  belongs_to :creneau
  belongs_to :aviron
  has_many :registres, dependent: :destroy
  has_many :rameurs, through: :registres

  validates :jour, presence: true
  validates :creneau_id, presence: true
  validates :aviron_id, presence: true

  scope :recent, -> { where("reservations.jour >= ?", Date.today) }
  scope :asc,    -> attr { order("reservations.#{attr} ASC") }
end
