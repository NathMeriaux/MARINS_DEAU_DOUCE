class Booking < ActiveRecord::Base
  belongs_to :user
  belongs_to :boat
  validates_presence_of :start_date, :end_date
  validate :start_must_be_before_end_date

  private

  def start_must_be_before_end_date

  end

end
