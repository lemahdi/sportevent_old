class Registre < ActiveRecord::Base
  belongs_to :user
  belongs_to :reservation

  validates_uniqueness_of :user_id, scope: :reservation_id
end
