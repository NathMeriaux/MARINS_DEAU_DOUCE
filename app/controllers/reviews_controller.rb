class ReviewsController < ApplicationController
  before_action :find_boat

  def new
    @review = Review.new
  end

  def create
    @review = @boat.reviews.build(reviews_params)
    if @review.save
      respond_to do |format|
        format.html { redirect_to boat_path(@boat) }
        format.js
      end
    else
      respond_to do |format|
        format.html { render 'restaurants/show' }
        format.js
      end
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
