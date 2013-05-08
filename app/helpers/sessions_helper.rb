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

	def current_rameur?(rameur)
		rameur == current_rameur
	end

  def signed_in_rameur
    unless signed_in?
      store_location
      respond_to do |format|
        format.html { redirect_to signin_url, notice: 'Merci de bien vouloir vous identifier' }
        format.json { render 'index', status: :unauthorized }
      end
    end
  end

  def correct_rameur
    set_rameur
    unless current_rameur?(@rameur)
      respond_to do |format|
        format.html { redirect_to root_url }
        format.json { render 'index', status: :unauthorized }
      end
    end
  end

  def admin_rameur
    unless current_rameur.admin?
        format.html { redirect_to root_url }
        format.json { render 'index', status: :unauthorized }
    end
  end

	def sign_out
		self.current_rameur = nil
		cookies.delete(:remember_token)
	end

	def redirect_back_or(default, msg)
		flash.now[:notice] = msg
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url
	end
end
