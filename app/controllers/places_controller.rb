class PlacesController < ApplicationController
  def index
    @places = policy_scope(Place)
  end

  def show
    @place = Place.find(params[:id])
    authorize @place
  end
end
