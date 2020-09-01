class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show]

  def show
  end

  private

  def set_response
    authorize @response
    @response = Response.find(params[:id])
  end
end
