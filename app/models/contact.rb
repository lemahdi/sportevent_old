class Contact
	include ActiveAttr::Model

	attribute :nom
	attribute :email
	attribute :content

	validates :nom   , presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email , presence:   true,
									 	 format:     { with: VALID_EMAIL_REGEXP },
									 	 uniqueness: { case_sensitive: false }
	validates_length_of :content, maximum: 500
end