class Boat < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :availabilities
  validates_presence_of :name, :location, :capacity, :price
end
