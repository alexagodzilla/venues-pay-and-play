class Review < ApplicationRecord
  belongs_to :booking, dependent: :destroy # i have added dependent destroy here to delete the review when the booking is deleted.

  validates :rating, presence: true, numericality: { only_integer: true }
  validates :comment, length: { minimum: 2 }
end
