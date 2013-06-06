class ContactController < ApplicationController
  before_filter :authenticate_rameur!, only: :update

  def new
  	@contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.valid?
        UserMailer.contact_email(@contact).deliver
        format.html { redirect_to root_url, notice: "Message envoyé" }
        format.json { head :no_content, status: :success, location: root_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @contact = Contact.new
    @contact.build(current_rameur, "")
    @contact.content = params[:content]
    reservation = Reservation.find_by_id(params[:reservation_id])
    destination = params[:destination]

    unless @contact.content.empty?
      if destination == "group"
        reservation.rameurs.each do |rameur|
          UserMailer.notify_group_email(@contact, rameur, reservation).deliver if rameur.id != current_rameur.id
        end
      elsif destination == "all"
        Rameur.all.each do |rameur|
          UserMailer.notify_group_email(@contact, rameur, reservation).deliver unless reservation.rameurs.include?(rameur)
        end
      end

      respond_to do |format|
        format.html { redirect_to reservation_path(reservation), notice: "Message envoyé" }
        format.json { render action: 'show', status: :updated, location: reservation }
     end
    else
      respond_to do |format|
        format.html { redirect_to reservation_path(reservation), alert: "Votre message est vide, il n'a pas été envoyé" }
        format.json { render action: 'show', status: :unprocessable_entity, alert: "Votre message est vide, il n'a pas été envoyé", location: reservation }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit(:nom, :email, :subject, :content)
    end
end
