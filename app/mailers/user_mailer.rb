class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(rameur)
  	@user = rameur
  	@url = "localhost:3000/signin"
  	mail(to: rameur.email, subject: "Bienvenue à la Yolette Parisienne")
  end
end
