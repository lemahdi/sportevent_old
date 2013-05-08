class Rameur < ActiveRecord::Base
	attr_accessible :nom, :prenom, :email,
									:password, :password_confirmation
	has_secure_password

	before_save { email.downcase! }
	before_save :create_remember_token

	validates :nom   , presence: true, length: { maximum: 50 }
	validates :prenom, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email , presence:   true,
									 	 format:     { with: VALID_EMAIL_REGEXP },
									 	 uniqueness: { case_sensitive: false }
	validates :password, presence: true, length: { minimum: 6 }
	validates :password_confirmation, presence: true

	private
		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
