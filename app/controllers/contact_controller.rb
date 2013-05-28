class ContactController < ApplicationController
  before_filter :signed_in_rameur, only: [:new, :create, :update]

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

  def update
    @contact = Contact.new(current_rameur)
    @contact.content = params[:content]
    reservation = Reservation.find_by_id(params[:reservation_id])
    reservation.rameurs.each do |rameur|
      UserMailer.notify_group_email(@contact, rameur, reservation).deliver if rameur.id != current_rameur.id
    end
    respond_to do |format|
      format.html { redirect_to edit_reservation_path(reservation), notice: "Message envoyé" }
      format.json { render action: 'show', status: :updated, location: reservation }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:nom, :email, :subject, :content)
    end
end
