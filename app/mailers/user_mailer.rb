class UserMailer < ActionMailer::Base
  default from: Rails.env.production? ? ENV['SENDGRID_USERNAME'] : "mahdi00@gmail.com"

  def welcome_email(user)
  	@contact = Contact.new
    @contact.build(user, "Bienvenue à SportEvent")
  	# attachements["file_name"] = File.read("file_path")
  	mail(to:      @contact.email,
  			 subject: "[SpEv-Bienvenu]: #{@contact.subject}")
  end

  def contact_email(contact)
  	@contact = contact
  	mail(to:      @contact.email,
  			 subject: "[SpEv-Contact]: #{@contact.subject}")
  end

  def notify_reservation_email(contact, user, reservation)
    @contact = contact
    @reservation = reservation
    @prenom = user.prenom
    mail(to:      user.email,
         subject: "[SpEv-Réservation] Confirmation: #{@contact.subject}")
  end

  def notify_group_email(contact, user, reservation)
    @contact = contact
    @reservation = reservation
    mail(to:      user.email,
         subject: "[SpEv-Réservation] Message: #{@contact.subject}")
  end
end
