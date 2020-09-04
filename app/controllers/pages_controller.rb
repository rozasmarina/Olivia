class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home]
  def home
    @places = Place.all
    @markers = @places.geocoded.map do |place|
      {
        lat: place.latitude,
        lng: place.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { place: place }),
        image_url: helpers.asset_url('marker.png')
      }
    end
    @rmarker = { createPlace: render_to_string(partial: "create_place"),
                 image_url: helpers.asset_url('marker.png') }
  end

  def together
  end

  def report
  end

  def community
  end

  def company
  end
end
