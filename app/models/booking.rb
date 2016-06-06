class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :boat
  validates_presence_of :start_date, :end_date
  validate :start_date_before_end_date

private

  def start_date_before_end_date
    if self.start_date > self.end_date
      errors.add(:start_date, "Start date should be before end date")
    end
  end

end
