class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update]

  def index
    @bookings = Booking.all
  end

  def bookings_user
    @bookings_users = current_user.bookings
    @boats = current_user.boats
  end

  def new
    @booking = Booking.new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :review_rating, :review_content)
  end
end
