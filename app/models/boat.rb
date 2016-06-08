class Boat < ActiveRecord::Base
  mount_uploader :boat_picture, PhotoUploader
  belongs_to :user
  has_many :bookings
  has_many :availabilities
  validates_presence_of :name, :location, :capacity, :price

  geocoded_by :location
  after_validation :geocode, if: :location_changed?

end
