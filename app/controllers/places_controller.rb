class PlacesController < ApplicationController
  def index
    @places = policy_scope(Place)
  end

  def show
    @place = Place.find(params[:id])
    authorize @place
  end

  def new
    @place = Place.new
    authorize @place
  end

  def create
    @place = Place.new(place_params)
    @place.user = current_user
    authorize @place

    if @place.save
      redirect_to @place, notice: 'Local adicionado com sucesso.'
    else
      render :new
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :latitude, :longitude)
  end
end
