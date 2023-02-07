class Venue < ApplicationRecord
  belongs_to :user

  validates :name, :location, presence: true
  validates :price_per_day, :size_of_band, presence: true, numericality: { only_integer: true }
end
