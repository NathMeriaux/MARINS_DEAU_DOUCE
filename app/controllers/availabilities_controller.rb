class AvailabilitiesController < ApplicationController
  before_action :find_boat

  def index
    @availabilities = @boat.availabilities
  end

  def new
    @availability = Availability.new
  end

  def create
    @availability = @boat.availabilities.build(availability_params)
    if @availability.save
      redirect_to boat_path(@boat)
    else
      flash[:alert] = "We could not save this availability."
    end
  end

  def edit
    @availability = @boat.availabilities.find(params[:id])
  end

  def update
    @availability = @boat.availabilities.find(params[:id])
    if @availability.update_attributes(availability_params)
      redirect_to boat_path(@boat)
    else
      flash[:alert] = "We could not update this availability."
    end
  end

  def destroy
    @availability = Availability.find(params[:id])
    @availability.destroy
    redirect_to boat_path(@boat)
  end

  private

  def find_boat
    @boat = Boat.find(params[:boat_id])
  end

  def availability_params
    params.require(:availability).permit(:boat_id, :start_date, :end_date)
  end

end
