class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
  	sign_out
  	super
  end

  protected
    # Store last url as long as it isn't a /sign_in or /sign_up path
    def store_location
      session[:previous_url] = request.fullpath  unless request.fullpath =~ /\/sign_/
    end

    # Redirect to stored page on successful sign in
    def after_sign_in_path_for(resource)
      session[:previous_url] || rameur_path(resource)
    end

    # Redirect to stored page on successful update
    def after_update_path_for(resource)
      rameur_path(resource)
    end

    # Redirect to root page on successful sign out
    def after_sign_out_path_for(resource)
      root_path
    end


end
