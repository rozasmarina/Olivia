class PlacesController < ApplicationController
  before_action :set_place, only: %i[show edit update]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @places = policy_scope(Place)
  end

  def show
    @reviews = @place.reviews.order('created_at desc')
    @review = Review.new
    authorize @place
  end

  def new
    @place = Place.new
    authorize @place
  end

  def create
    @place = Place.new(place_params)
    current_user.is_business ? @place.owner = current_user : @place.user = current_user
    authorize @place
    if @place.save
      redirect_to @place, notice: 'Local adicionado com sucesso.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @place.update(place_params)
      redirect_to @place, notice: 'Local editado com sucesso.'
    else
      render :edit
    end
  end

  def add_owner
    @place = Place.find(params[:owner][:place])
    authorize @place
    @place.owner = current_user
    if @place.save
      redirect_to users_path
    else
      @user = current_user
      @places = Place.where(owner: nil)
      render 'users/show'
    end
  end

  private

  def place_params
    params.require(:place).permit(:name, :address, :photo)
  end

  def set_place
    @place = Place.find(params[:id])
    authorize @place
  end
end
