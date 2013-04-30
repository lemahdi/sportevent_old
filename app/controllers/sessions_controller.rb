class SessionsController < ApplicationController

	def new
	end

	def create
    rameur = Rameur.find_by_email(params[:session][:email].downcase)
    respond_to do |format|
      if rameur && rameur.authenticate(params[:session][:password])
    		# Sign the rameur in and redirect to the rameur's show page.
        format.html { redirect_to rameur }
        format.json { render action: 'show', status: :created, location: rameur }
      else
        format.html { render action: 'new' }
        format.json { render json: rameur.errors, status: :unprocessable_entity }
      end
    end
	end

	def destroy
	end
end
