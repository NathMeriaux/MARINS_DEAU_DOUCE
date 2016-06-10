class ReviewsController < ApplicationController
  before_action :find_boat

  def new
    @review = Review.new
  end

  def create
    @review = @boat.reviews.build(reviews_params)
    if @review.save
      redirect_to boat_path(@boat)
    else
      flash[:alert] = "We could not save this review."
    end
  end

  def index
    @reviews = @boat.reviews
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def find_boat
    @boat = Boat.find(params[:boat_id])
  end

  def reviews_params
    params.require(:review).permit(:content)
  end
end
