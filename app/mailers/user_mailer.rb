class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user    
    mail to: @user.email, subject: "Welcome to Marins d'eau douce"
  end
end
