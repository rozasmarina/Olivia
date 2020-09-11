class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home top_places near_me recommended community together ollivia]

  def home
    @places = Place.all
    @markers = @places.geocoded.map do |place|
      { lat: place.latitude, lng: place.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url('marker.png') }
    end
    @rmarker = { createPlace: render_to_string(partial: "create_place"),
                 image_url: helpers.asset_url('rmarker.png') }
  end

  def near_me
    @places = Place.near(current_user, 2)
    @places = Place.near(current_user, 5) if @places == []
    @places = Place.near(current_user, 7) if @places == []
    if @places == []
      redirect_to root_path, notice: 'Nenhum local próximo encontrado'
    else
      @markers = @places.geocoded.map do |place|
        { lat: place.latitude, lng: place.longitude,
          infoWindow: render_to_string(partial: "info_window", locals: { place: place }),
          image_url: helpers.asset_url('marker.png') }
      end
      @rmarker = { createPlace: render_to_string(partial: "create_place"),
                   image_url: helpers.asset_url('rmarker.png') }
    end
  end

  def top_places
    @places = Place.all
    @top_places = @places.geocoded.sort { |a, b| b.average_rating <=> a.average_rating }
    @markers = @top_places.first(5).map do |place|
      { lat: place.latitude, lng: place.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url('marker.png') }
    end
    @rmarker = { createPlace: render_to_string(partial: "create_place"),
                 image_url: helpers.asset_url('rmarker.png') }
  end

  def recommended
  end

  def together
  end

  def ollivia
    @places = Place.all
    @satisfied = Review.where(is_satisfied: true)
  end

  def community
  end

  def emergency
  end
end
