class BoatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index_all, :show]
  before_action :set_boat, only: [:edit, :show, :destroy]

  def new
    @boat = Boat.new
  end

  def index_all
    @boats = Boat.all
    if not params[:location].blank?
      @boats = @boats.where("location LIKE ?", "%#{params[:location]}%")
    end
    if not params[:capacity].blank?
      @boats = @boats.where("capacity >= ?", params[:capacity])
    end
    # 4 conditions:
      # start_date <= end_date
      # start_date belongs to an availability
      # end_date belongs to an availability
      # start_date_availability_id = end_date.availability_id
    if (not params[:start_date].blank?) && (not params[:end_date].blank?) && (params[:start_date].to_date < params[:end_date].to_date)
      check_availability(@boats, params[:start_date].to_date, params[:end_date].to_date)
    end
    #Create markers for gmaps with filtered boats
    @markers = Gmaps4rails.build_markers(@boats) do |boat, marker|
      marker.lat boat.latitude
      marker.lng boat.longitude
    end
  end

  def check_availability(boats, start_date, end_date)
    filtered_boats = []
    boats.each do |boat|
      if available(boat, start_date, end_date) > 0
        filtered_boats << boat
      end
    end
    @boats = filtered_boats
  end

  def available(boat, start_date, end_date)
    counter = 0
    boat.availabilities.each do |availability|
      if start_date >= availability.start_date && end_date <= availability.end_date
        counter += 1
      end
    end
    counter
  end

  def index
    @boats = current_user.boats
  end

  def create
    @user = current_user
    @boat = current_user.boats.build(boat_params)
    @boat.user_id = current_user.id if current_user
    if @boat.save
      BoatMailer.creation_confirmation(@boat, @user).deliver_now
      redirect_to boats_path
    else
      flash[:alert] = "Boat not created!"
    end

  end

  def edit
  end

  def show
    @availabilities = @boat.availabilities
    @marker_show = Gmaps4rails.build_markers(@boat) do |boat, marker|
      marker.lat boat.latitude
      marker.lng boat.longitude
    end
    @booking = Booking.new
  end

  def update
    boat = current_user.boats.find(params[:id])
    if boat.update!(boat_params)
      redirect_to boat
    else
      flash[:alert] = "Boat not updated!"
    end
  end

  def destroy
    if @boat.destroy
      redirect_to boats_path
    else
      flash[:alert] = "Boat not deleted!"
    end
  end

private

  def boat_params
    params.require(:boat).permit(:name, :location, :capacity, :boat_picture, :price, :boat_picture_cache)
  end

  def set_boat
    @boat = Boat.find(params[:id])
  end
end
