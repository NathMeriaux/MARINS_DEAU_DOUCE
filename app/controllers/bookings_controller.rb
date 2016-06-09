class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update]
  before_action :find_boat

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
    @booking = current_user.bookings.build(booking_params)
    @booking.user_id = current_user.id if current_user
    @booking.boat_id = @boat.id
    if @booking.save
      redirect_to boat_booking_path(@boat, @booking)
    else
      flash[:alert] = "booking not created!"
    end
  end

  def show
  end

  def edit
  end

  def update
    @booking = current_user.bookings.find(params[:id])
    if booking.update!(booking_params)
      redirect_to booking
    else
      flash[:alert] = "Booking not updated!"
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def find_boat
    @boat = Boat.find(params[:boat_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status, :review_rating, :review_content)
  end
end
