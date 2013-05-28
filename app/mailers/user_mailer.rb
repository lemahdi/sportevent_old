class UserMailer < ActionMailer::Base
  default from: Rails.env.production? ? ENV['SENDGRID_USERNAME'] : "mahdi00@gmail.com"

  def welcome_email(rameur)
  	@contact = Contact.new(rameur)
  	# attachements["file_name"] = File.read("file_path")
  	mail(to:      @contact.email,
  			 subject: "[LYP-Bienvenu]: Bienvenue à la Yolette Parisienne")
  end

  def contact_email(contact)
  	@contact = contact
  	mail(to:      @contact.email,
  			 subject: "[LYP-Contact]: #{@contact.subject}")
  end

  def notify_reservation_email(contact, rameur, reservation)
    @contact = contact
    @reservation = reservation
    @prenom = rameur.prenom
    mail(to:      rameur.email,
         subject: "[LYP-Réservation] Confirmation: #{contact.subject}")
  end

  def notify_group_email(contact, rameur, reservation)
    @contact = contact
    @reservation = reservation
    mail(to:      rameur.email,
         subject: "[LYP-Réservation] Message: #{contact.subject}")
  end
end
