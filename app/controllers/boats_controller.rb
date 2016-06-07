class BoatsController < ApplicationController


  def new
    @boat = Boat.new
  end

  def index_all
    @boats = Boat.all
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
      flash[:notice] = "Boat not created!"
    end

  end

  def edit
    @boat = Boat.find(params[:id])
  end

  def show
    @boat = Boat.find(params[:id])
  end

  def update
    boat = current_user.boats.find(params[:id])
    boat.update!(boat_params)
    redirect_to boat
  end

  # def update
  #  @boat = Boat.find(params[:id])

  #    if @boat.update_attributes(boat_param)
  #       redirect_to :action => 'show', :id => @boat
  #    else
  #       @subjects = Subject.all
  #       render :action => 'edit'
  #    end

  # end

  def destroy
    @boat = Boat.find(params[:id])
    @boat.destroy
    redirect_to boats_path
  end

private

  def boat_params
    params.require(:boat).permit(:name, :location, :capacity, :boat_picture)
  end



end
