class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update]
  before_action :find_boat, only: [:new, :create]

  def index
    @bookings = Booking.all
  end

  def bookings_user
    @bookings_users = current_user.bookings
    @boats = current_user.boats
  end

  def new
  end

  def check_create
    (@booking.start_date.present?) &&
    (not @booking.end_date.blank?) &&
    (@booking.start_date < @booking.end_date)
  end

  def create
    @booking = current_user.bookings.build(booking_params)
    if check_create
      check_availability(@boat, @booking.start_date, @booking.end_date)

      if @availability != nil
        @booking.boat_id = @boat.id

        if @booking.save
          update_availabilities(@availability, @booking.start_date, @booking.end_date)
          @booking.update_attribute(:status, "pending")
          flash[:notice] = "your reservation has been sent to the owner"
          redirect_to boat_booking_path(@boat, @booking)
        else
          flash[:alert] = "booking not created!"
        end
      else
        flash[:alert] = "This boat is not available at these dates"
      end
    else
        flash[:alert] = "Please enter start date < end date"
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

  def check_availability(boat, start_date, end_date)
    boat.availabilities.each do |availability|

      if start_date >= availability.start_date && end_date <= availability.end_date
      @availability = availability
    end
    end
    @availability
  end

  def update_availabilities(availability, start_date, end_date)
    availability1 = @boat.availabilities.build(start_date: availability.start_date, end_date: start_date).save if start_date != availability.start_date
    availability2 = @boat.availabilities.build(start_date: end_date, end_date: availability.end_date).save if end_date != availability.end_date
    availability.destroy
  end
end
