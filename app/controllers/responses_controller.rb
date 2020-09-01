class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show]

  def show
  end

  def new
    @response = Response.new
  end

  private

  def set_response
    authorize @response
    @response = Response.find(params[:id])
  end
end