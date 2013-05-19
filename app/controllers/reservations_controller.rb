class ReservationsController < ApplicationController
  before_action :set_reservation,  only: [:show, :edit, :update, :destroy]
  
  before_filter :signed_in_rameur, only: [:index, :new, :create, :update, :destroy]
  before_filter :check_params,     only: :create

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.recent.asc("jour").paginate(page: params[:page], per_page: 30)
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
        @reservation.rameurs << current_rameur
        flash[:changed_reservation] = @reservation.id

        format.html { redirect_to reservations_url, notice: 'Reservation enregistrée' }
        format.json { render action: 'index', status: :created, location: reservations_url }
      else
        format.html { render action: 'new', locals: { jour: @reservation.jour } }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      flash[:changed_reservation] = @reservation.id
      if params[:participate] == "yes"
        @reservation.rameurs << current_rameur
        message = "Félicitations, vous avez rejoins l'équipage"
      else
        @reservation.rameurs.delete(current_rameur)
        message = "Vous avez quitté l'équipage"
      end

      format.html { redirect_to reservations_url, notice: message }
      format.json { render action: 'index', status: :updated, location: reservations_url }
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
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

      if jour.to_date < Date.today
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
end
