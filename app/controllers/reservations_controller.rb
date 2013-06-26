include ReservationsHelper

class ReservationsController < ApplicationController
  before_action :set_reservation,           only: [:show, :update, :destroy]
  
  before_filter :authenticate_user!
  before_filter :check_params,              only: :create
  before_filter :subscribed_to_reservation, only: [:show, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.recent.asc("jour").paginate(page: params[:page], per_page: 30)
    @user = User.find(params[:user_id]) if params[:user_id].present?

    respond_to do |format|
      format.html { @reservations }
      format.json {
        render json: {
          current_page:  @reservations.current_page,
          per_page:      @reservations.per_page,
          total_entries: @reservations.total_entries,
          entries:       @reservations
        }
      }
    end
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @reservation = Reservation.new(reservation_params)

    respond_to do |format|
      if @reservation.save
        @reservation.users << current_user
        flash[:changed_reservation] = @reservation.id

        format.html { redirect_to reservations_url, notice: "Réservation enregistrée" }
        format.json { render action: 'index', status: :created, location: reservations_url }
      else
        format.html { render action: 'new' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    if params[:from_page] == "index"
      flash[:changed_reservation] = @reservation.id
      if params[:participate] == "yes"
        @reservation.users << current_user
        message = "Félicitations, vous faites partie de l'équipage"
      else
        @reservation.users.delete(current_user)
        message = "Vous avez quitté l'équipage"
      end
      respond_to do |format|
        format.html { redirect_to reservations_url, notice: message }
        format.json { render action: 'index', status: :updated, location: reservations_url }
      end

    elsif params[:reservation][:from_page] == "show"
      if @reservation.confirmation
        message = "Réservation déjà confirmée"
        respond_to do |format|
          format.html { redirect_to reservation_url(@reservation), alert: message }
          format.json { render action: 'show', alert: message, location: reservation_url(@reservation) }
        end
      else
        @reservation.confirmation = true
        @reservation.responsable_id = current_user.id
        respond_to do |format|
          if @reservation.save
            nb_users = @reservation.users.size
            if nb_users > 1
              # Notify the users
              contact = Contact.new
              contact.build(current_user, "")
              @reservation.users.each do |user|
                UserMailer.notify_reservation_email(contact, user, @reservation).deliver if user.id!=current_user.id
              end
            end

            message = "Réservation confirmée"
            if nb_users > 1
              message += ", tous les users ont été notifiés par mail"
            end
            format.html { redirect_to reservation_url(@reservation), notice: message }
            format.json { render action: 'show', status: :updated, location: reservation_url(@reservation) }
          else
            format.html { render action: 'show' }
            format.json { render json: @reservation.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Réservation annulée" }
      format.json { head :no_content, status: :success }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:jour, :creneau_id, :aviron_id)
    end

    # Check the conformity of the crenau with the aviron type
    def check_params
      jour = reservation_params[:jour]
      creneau_id = reservation_params[:creneau_id]

      flash[:jour] = jour
      flash[:creneau_id] = creneau_id
      flash[:aviron_id] = reservation_params[:aviron_id]

      jour_date = Date.parse(jour) rescue nil

      if jour_date.nil?
        flash[:jour] = Date.today.strftime('%d-%m-%Y')
        is_valid = false
        message = "Le jour de réservation n'est pas valide"
      elsif jour.to_date < Date.today
        is_valid = false
        message = "Le jour de réservation doit être postérieur à aujourd'hui"
      elsif creneau_id.include?("---") || creneau_id==""
        is_valid = false
        message = "Le créneau horaire que vous avez choisi est incorrect"
      else
        creneau = Creneau.find(creneau_id)
        aviron = Aviron.find(reservation_params[:aviron_id])

        delta = creneau.fin - creneau.debut
        is_valid = delta==45.minutes && (aviron.description=="simple" || aviron.description=="double")
        is_valid ||= delta==1.hour && aviron.description=="yolette"

        message = "Le créneau horaire que vous avez choisi ne correspond pas au type d'aviron"
      end

      unless is_valid
        respond_to do |format|
          format.html { redirect_to new_reservation_path, alert: message }
          format.json { render 'new', status: :unauthorized, alert: message }
        end
      end
    end

    # Verify that the current user is subscribed to the reservation he tries to show
    def subscribed_to_reservation
      unless subscribed?(@reservation)
        message = "Vous n'êtes pas inscrit(e) à cette réservation"
        respond_to do |format|
          format.html { redirect_to reservations_url, alert: message }
          format.json { render 'show', status: :unauthorized, alert: message }
        end
      end
    end
end
