class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show edit update disable disabled]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @reviews = policy_scope(Review)
    @active_reviews = policy_scope(Review).where("is_disabled = ?", false)
  end

  def show
    @response = Response.new
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
      average_rating(@review.place)
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
      redirect_to @review, notice: 'Alteração realizada com sucesso.'
    else
      render :edit
    end
  end

  def disable
  end

  # WILL UPDATE THE REVIEW USING ACTION UPDATE
  # def disabled
  #   @review.update(review_params)
  #   raise
  #   if @review.update(review_params)
  #     redirect_to @review, notice: 'Avaliação desabilitada com sucesso.'
  #   else
  #     render :disable
  #   end
  # end

  private

  def average_rating(place)
    reviews = Review.where('place_id = ?', place.id)
    ratings = reviews.map(&:rating)
    place.update_attribute(:average_rating, ratings.sum / ratings.length.to_f)
  end

  def review_params
    params.require(:review).permit(:content, :rating, :title, :is_good, :is_anonymous, :is_disabled)
  end

  def set_review
    @review = Review.find(params[:id])
    authorize @review
  end
end
