class BookingsController < ApplicationController
  def index
  end

  def bookings_user
    @bookings_users = current_user.bookings
    # @bookings_owners = current_user.boats.bookings
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end
end
