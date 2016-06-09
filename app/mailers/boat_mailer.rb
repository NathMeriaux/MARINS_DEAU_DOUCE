class BoatMailer < ApplicationMailer
  def creation_confirmation(boat, user)
    @user = user
    @boat = boat
    mail to: @boat.user.email, subject: "Boat #{@boat.name} created!"
  end
end
