class Reservation < ActiveRecord::Base
  attr_accessible :jour, :creneau_id, :aviron_id, :confirmation

  belongs_to :creneau
  belongs_to :aviron
  has_many :registres, dependent: :destroy
  has_many :rameurs, through: :registres

  validates :jour, presence: true
  validates :creneau_id, presence: true
  validates :aviron_id, presence: true
  validate :empty_place

  scope :recent, -> { where("reservations.jour >= ?", Date.today) }
  scope :asc,    -> attr { order("reservations.#{attr} ASC") }

  private
    def empty_place
      errors.add(:aviron, "Aviron #{aviron.id} is full") if self.rameurs.size > self.aviron.nbplaces
    end
end
