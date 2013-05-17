class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  
  before_filter :signed_in_rameur, only: [:index, :new, :create, :update]

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
        flash[:new_reservation] = @reservation.id

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
      if !already_subscribed?(current_rameur, @reservation)
        @reservation.rameurs << current_rameur
        flash[:new_reservation] = @reservation.id

        format.html { redirect_to reservations_url, notice: "Félicitations, vous faites partie de l'équipage" }
        format.json { render action: 'index', status: :updated, location: reservations_url }
      else
        format.html { render action: 'index' }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
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
end
