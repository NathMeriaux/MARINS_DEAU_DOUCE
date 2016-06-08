class UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    user = current_user.find(user_params)
    if user.update_attributes(user_params)
      redirect_to user
    else
      flash[:alert] = "Profile not updated!"
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :password, :email, :profile_picture, :profile_picture_cache)
  end
end
