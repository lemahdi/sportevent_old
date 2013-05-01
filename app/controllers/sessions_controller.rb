class SessionsController < ApplicationController

	def new
	end

	def create
    rameur = Rameur.find_by_email(params[:session][:email].downcase)
    respond_to do |format|
      if rameur && rameur.authenticate(params[:session][:password])
    		# Sign the rameur in and redirect to the rameur's show page.
    		sign_in rameur
        flash.now[:notice] = 'Connexion réussie'
        format.html { redirect_back_or rameur }
        format.json { render action: 'show', status: :created, location: rameur }
      else
      	flash.now[:error] = 'Informations erronées'
        format.html { render action: 'new' }
        format.json { render json: rameur.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
		sign_out
    flash.now[:error] = 'Vous avez été déconnecté avec succès'
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
	end
end
