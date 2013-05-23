class UserMailer < ActionMailer::Base
  default from: Rails.env.production? ? ENV['SENDGRID_USERNAME'] : "mahdi00@gmail.com"

  def welcome_email(rameur)
  	@user = rameur
  	# attachements["file_name"] = File.read("file_path")
  	mail(to:      rameur.email,
  			 subject: "Bienvenue à la Yolette Parisienne")
  end
end
