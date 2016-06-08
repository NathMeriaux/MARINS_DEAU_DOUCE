class Boat < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :availabilities
  validates_presence_of :name, :location, :capacity, :price

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

end
