class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show]
  def index
    @reviews = policy_scope(Review)
  end

  def show
    @response = Response.new
    authorize @review
  end

  # def new
  #   @review = Review.new
  #   authorize @review
  # end

  def create
    @review = Review.new(review_params)
    @review.place = Place.find(params[:place_id])
    @review.user = current_user
    authorize @review
    if @review.save
      redirect_to review_path(@review)
    else
      @place = @review.place
      render "places/show"
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :title)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
