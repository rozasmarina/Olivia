class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home top_places near_me recommended]
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
  end

  def top_places
    @places = Place.all
    @markers = @places.first(5).geocoded.map do |place|
      { lat: place.latitude, lng: place.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url('marker.png') }
    end
    @rmarker = { createPlace: render_to_string(partial: "create_place"),
                 image_url: helpers.asset_url('rmarker.png') }
    raise
  end

  def recommended
  end
end
