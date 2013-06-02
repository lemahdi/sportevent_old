class Rameur < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	attr_accessible :nom, :prenom, :email,
									:password, :password_confirmation,
									:remember_me

	has_many :registres, dependent: :destroy
	has_many :reservations, through: :registres

	before_save { email.downcase! }

	VALID_NAME = /\A[a-zA-Z][a-zA-Z0-9_ ]+\z/i
	validates :nom   , presence: true,
										 length:   { maximum: 50 },
										 format:   { with: VALID_NAME, message: "doit commencer par un caractère alphabétique et ne peut contenir que les caractères espace, alphanumériques et _" }
	validates :prenom, presence: true,
										 length:   { maximum: 50 },
										 format:   { with: VALID_NAME, message: "doit commencer par un caractère alphabétique et ne peut contenir que les caractères espace, alphanumériques et _" }
	VALID_EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email , presence:   true,
									 	 format:     { with: VALID_EMAIL_REGEXP },
									 	 uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 8 }
	validates :password_confirmation, presence: true

  scope :asc, -> attr { order("rameurs.#{attr} ASC") }
end
