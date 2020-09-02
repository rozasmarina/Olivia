class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update]
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
    # raise
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

  def edit
  end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: 'Local editado com sucesso.'
    else
      render :edit
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating, :title, :is_good, :is_anonymous)
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end
end
