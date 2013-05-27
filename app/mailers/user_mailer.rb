class UserMailer < ActionMailer::Base
  default from: Rails.env.production? ? ENV['SENDGRID_USERNAME'] : "mahdi00@gmail.com"

  def welcome_email(rameur)
  	@nom = "#{rameur.nom} #{rameur.prenom}"
  	# attachements["file_name"] = File.read("file_path")
  	mail(to:      rameur.email,
  			 subject: "Bienvenue à la Yolette Parisienne")
  end

  def contact_email(contact)
  	@nom = contact.nom
  	@content = contact.content
  	mail(to:      contact.email,
  			 subject: "[LYP-Contact] #{contact.subject}")
  end

  def notify_reservation_email(rameur, responsable, reservation)
    @nom = "#{responsable.nom} #{responsable.prenom}"
    @responsable = responsable
    @reservation = reservation
    mail(to:      rameur.email,
         subject: "[LYP-Réservation] confirmation")
  end
end
