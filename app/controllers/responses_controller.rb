class ResponsesController < ApplicationController
  before_action :set_response, only: %i[show]

  def show
  end

  # def new
  #   @response = Response.new
  #   @review = Review.find(params[:id])
  #   authorize @review, :create_response?
  # end

  def create
    @response = Response.new(response_params)
    @response.review = Review.find(params[:review_id])
    @response.user = current_user
    authorize @response
    if @response.save
      redirect_to review_path(params[:review_id])
    else
      @review = @response.review
      render "reviews/show"
    end
  end

  private

  def set_response
    @response = Response.find_by(id: params[:id])
    if @response.nil?
      redirect_to root_path, notice: "Resposta não encontrada."
    else
      authorize @response
    end
  end

  def response_params
    params.require(:response).permit(:response, :title)
  end
end
