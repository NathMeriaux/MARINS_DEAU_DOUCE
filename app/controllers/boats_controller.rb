class BoatsController < ApplicationController
before_action :find_user

  def new
    @boat = Boat.new
  end

  def index
    @boats = Boat.all
  end

  def index_owner
    @boats = @user.boats
  end

  def create
    @boat = @user.boats.build(boat_params)
    @boat.user_id = current_user.id if current_user
    if @boat.save
      redirect_to boats_path
    else
      flash[:notice] = "Boat not created!"
    end

  end

  def edit

  end

  def show
    @boat = Boat.find(params[:id])
  end

  def update
  end

  def destroy
    @boat = Boat.find(params[:id])
    @boat.destroy
  end

private

  def boat_params
    params.require(:boat).permit(:name, :location, :capacity, :boat_picture)
  end

  def find_user
    @user = current_user
  end

end
