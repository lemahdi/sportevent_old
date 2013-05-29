class Contact
	include ActiveAttr::Model

	attribute :nom
	attribute :email
	attribute :subject
	attribute :content
	attribute :rameur

	validates :nom, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
	validates :email , presence: true, format: { with: VALID_EMAIL_REGEXP }
	validates_length_of :subject, maximum: 50
	validates :content, presence: true, length: { maximum: 500 }

	def build(rameur, subject)
		self.nom = "#{rameur.nom} #{rameur.prenom}"
		self.email = rameur.email
		self.subject = subject
		self.rameur = rameur
	end
end