class PlacesController < ApplicationController
  @places = policy_scope(Place)
end
