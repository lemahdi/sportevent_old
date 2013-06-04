class Rameur < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :token_authenticatable, :confirmable, :lockable,
  			 :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	attr_accessible :nom, :prenom, :email,
									:password, :password_confirmation,
									:remember_me

	has_many :registres, dependent: :destroy
	has_many :reservations, through: :registres

	before_save { email.downcase! }

	VALID_NAME = /\A[a-zA-Z][a-zA-Z0-9_ ]+\z/i
	validates :nom   , presence: false,
										 length:   { maximum: 50 }
	validates :prenom, presence: false,
										 length:   { maximum: 50 }
	VALID_EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email , presence:   true,
									 	 format:     { with: VALID_EMAIL_REGEXP },
									 	 uniqueness: { case_sensitive: false }

  scope :asc, -> attr { order("rameurs.#{attr} ASC") }

  def admin?
  	false
  end

  def password_required?
  	super if confirmed?
  end

  def password_match?
    self.errors[:password] << "ne peut pas être vide" if password.blank?
    self.errors[:password_confirmation] << "ne peut pas être vide" if password_confirmation.blank?
    self.errors[:password_confirmation] << "ne correspond pas au mot de passe" if password != password_confirmation
    password == password_confirmation && !password.blank?
  end
end
