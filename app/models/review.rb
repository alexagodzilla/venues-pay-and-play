class Review < ApplicationRecord
  belongs_to :booking
  validates :rating, presence: true, numericality: { only_integer: true }
  validates :comment, length: { minimum: 2 }
end
