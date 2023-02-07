class Booking < ApplicationRecord
  belongs_to :venue
  belongs_to :user

  validates :start_date, presence: true, comparison: { greater_than: :end_date }
  validates :end_date, presence: true
end
