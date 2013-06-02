class Rameurs::RegistrationsController < Devise::RegistrationsController
	before_filter :configure_permitted_parameters

  # def resource_params
  #   params.require(:rameur).permit(:nom, :prenom, :email, :password, :password_confirmation)
  # end

  protected
  	def configure_permitted_parameters
	  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:nom, :prenom, :email, :password, :password_confirmation) }
	  end

  # private
  # 	:resource_params

end