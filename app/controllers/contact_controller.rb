class ContactController < ApplicationController
  def new
  	@contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.valid?
        UserMailer.contact_email(@contact).deliver
        format.html { redirect_to root_url, notice: 'Message envoyé' }
        format.json { head :no_content, status: :success, location: root_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:nom, :email, :subject, :content)
    end
end
