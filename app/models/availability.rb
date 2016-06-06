class Availability < ActiveRecord::Base
  belongs_to :boat
  validates_presence_of :start_date, :end_date
end
