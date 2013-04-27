class RameursController < ApplicationController
  before_action :set_rameur, only: [:show, :edit, :update, :destroy]

  # GET /rameurs
  # GET /rameurs.json
  def index
    @rameurs = Rameur.all
  end

  # GET /rameurs/1
  # GET /rameurs/1.json
  def show
  end

  # GET /rameurs/new
  def new
    @rameur = Rameur.new
  end

  # GET /rameurs/1/edit
  def edit
  end

  # POST /rameurs
  # POST /rameurs.json
  def create
    @rameur = Rameur.new(rameur_params)

    respond_to do |format|
      if @rameur.save
        format.html { redirect_to @rameur, notice: 'Rameur was successfully created.' }
        format.json { render action: 'show', status: :created, location: @rameur }
      else
        format.html { render action: 'new' }
        format.json { render json: @rameur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rameurs/1
  # PATCH/PUT /rameurs/1.json
  def update
    respond_to do |format|
      if @rameur.update(rameur_params)
        format.html { redirect_to @rameur, notice: 'Rameur was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @rameur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rameurs/1
  # DELETE /rameurs/1.json
  def destroy
    @rameur.destroy
    respond_to do |format|
      format.html { redirect_to rameurs_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rameur
      @rameur = Rameur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rameur_params
      params.require(:rameur).permit(:nom, :prenom, :email)
    end
end
