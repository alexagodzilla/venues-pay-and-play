class Booking < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :reviews, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true, comparison: { greater_than_or_equal_to: :start_date }
end
