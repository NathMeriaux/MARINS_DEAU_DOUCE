class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path
    else
      flash[:alert] = "Profile not updated!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :profile_picture, :profile_picture_cache)
  end
end
