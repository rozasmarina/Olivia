class ReviewsController < ApplicationController
  before_action :set_review, only: %i[show]
  def index
    @reviews = policy_scope(Review)
  end

  def show
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
