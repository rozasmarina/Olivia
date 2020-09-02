class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show]

  def show
  end

  def new
    @response = Response.new
    @review = Review.find(params[:id])
    authorize @review, :create_response?
  end

  def create
    @response = Response.new(response_params)
    @response.review = Review.find(params[:review_id])
    @response.user = current_user
    authorize @response
    if @response.save
      redirect_to review_path(params[:review_id])
    else
      render :new
    end
  end

  private

  def set_response
    authorize @response
    @response = Response.find(params[:id])
  end

  def response_params
    params.require(:response).permit(:response, :title)
  end
end
