class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show]

  def show
  end

  def new
    @response = Response.new
    @review = Review.find(params[:review_id])
    authorize @response
  end

  private

  def set_response
    authorize @response
    @response = Response.find(params[:id])
  end
end
