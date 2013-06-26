class Reservation < ActiveRecord::Base
  attr_accessible :jour, :creneau_id, :aviron_id, :confirmation, :responsable_id

  belongs_to :creneau
  belongs_to :aviron
  belongs_to :user, class_name: "User", foreign_key: "responsable_id"
  has_many :registres, dependent: :destroy
  has_many :users, through: :registres

  validates :jour, presence: true
  validates :creneau_id, presence: true
  validates :aviron_id, presence: true
  validate :empty_place, :jour_cannot_be_after_3months

  scope :recent, -> { where("reservations.jour >= ?", Date.today) }
  scope :asc,    -> attr { order("reservations.#{attr} ASC") }

  private
    def empty_place
      errors.add(:aviron, "#{aviron.id} est rempli") if self.users.size > self.aviron.nbplaces
    end

    def jour_cannot_be_after_3months
      errors.add(:jour, "ne peut pas être au delà de 3 mois") if self.jour > (Date.today+3.months)
    end
end
