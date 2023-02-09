class Venue < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, through: :bookings, dependent: :destroy
  has_one_attached :photo

  validates :name, :location, presence: true
  validates :price_per_day, :size_of_band, presence: true, numericality: { only_integer: true }
end
