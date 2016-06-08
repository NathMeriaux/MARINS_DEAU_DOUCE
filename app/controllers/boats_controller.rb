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
      @boats = @boats.where("capacity = ?", params[:capacity])
    end
    #Create markers for gmaps with filtered boats
    @markers = Gmaps4rails.build_markers(@boats) do |boat, marker|
      marker.lat boat.latitude
      marker.lng boat.longitude
    end
  end

  def index
    @boats = current_user.boats
  end

  def create
    @boat = current_user.boats.build(boat_params)
    @boat.user_id = current_user.id if current_user
    if @boat.save
      redirect_to boats_path
    else
      flash[:alert] = "Boat not created!"
    end

  end

  def edit
  end

  def show
    @availabilities = @boat.availabilities
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
