module ApplicationHelper
end

def average_rating(venue_reviews)
  all_ratings = 0
  venue_reviews.each { |review| all_ratings += review.rating }
  (all_ratings / venue_reviews.count.to_f).round(1)
end
