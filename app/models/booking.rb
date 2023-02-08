class Booking < ApplicationRecord
  belongs_to :venue
  belongs_to :user
  has_many :reviews

  validates :start_date, presence: true
  validates :end_date, presence: true
end

# , comparison: { greater_than: :end_date }
