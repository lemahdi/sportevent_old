module SessionsHelper

	def sign_in(rameur)
		cookies.permanent[:remember_token] = rameur.remember_token
		self.current_rameur = rameur
	end

	def signed_in?
		!current_rameur.nil?
	end

	def current_rameur=(rameur)
		@current_rameur = rameur
	end

	def current_rameur
		@current_rameur ||= Rameur.find_by_remember_token(cookies[:remember_token])
	end

	def sign_out
		self.current_rameur = nil
		cookies.delete(:remember_token)
	end
end
