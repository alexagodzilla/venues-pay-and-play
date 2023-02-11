require 'date'
require 'open-uri'
require 'json'
api_key = 'AIzaSyBT8K8ea7m_bZfRRvbVNnyZJigwW3llnOQ'

location = "Manchester" #change this to the location you want to search for

#-----GOOGLE API-----
url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=music%20rehearsal%20venues%20in%20#{location}&limit=15&key=#{api_key}"
music_venues = JSON.parse(URI.open(url).read)['results']
puts music_venues.first
#-----CLEANING DB-----
puts "destroying review database"
Review.destroy_all

puts "destroying booking database"
Booking.destroy_all

puts "destroying venue database"
Venue.destroy_all

puts "destroying user database"
User.destroy_all

# -----------------
puts "creating users"
20.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.unique.last_name,
    email: "#{Faker::Name.first_name}@#{Faker::Name.unique.last_name}.com",
    password: "banana"
  )
  user.save!
end

puts "creating venues"
venue_images = %w(pgfw7mefk6chajc7bmm6
  nt5lseqqycqydw1tdta8
  f2ttnamqghm1dbvpl7oh
  nq8qgd05epmwd6h5vvyl
  qaa9ffkc5gulgipbzrqe
  oa6szektwkwp9neiclzk
  gr83xmqnsjtevj9j5dpl
  ym8k3n70q2qbcj8ngblq
  ipbhbonqzsofoulmtjqf
  gyyssr3tzunwiikuc0f2
  mhmxhdutjrdchwosnygg
  qwhp5aqbuedpix7w0r4w
  j41exrcmxznuxb6zmgjj
  uh2kiuhlpqe7mkxvxtct)

  for rehearsal_venue in music_venues do
  user = User.all.sample
  venue = Venue.new(
    # name: "This is a name",
    name: rehearsal_venue['name'],
    price_per_day: rand(50..100),
    location: rehearsal_venue['formatted_address'],
    # location: "This is an address",
    size_of_band: rand(1..7),
    phone_number: "07#{rand(10**9)}",
    description: Faker::Hipster.paragraph,
    pic_url:  venue_images.sample
  )
  venue.user = user
  venue.save!
end

puts "creating bookings - 10 available"
10.times do
  user = User.all.sample
  venue = Venue.all.sample
  date = Date.today + rand(5..25)
  booking = Booking.new(
    start_date: date,
    end_date: date + 1
  )
  booking.user = user
  booking.venue = venue
  booking.save!
end

puts "creating bookings - 5 unavailable (with same date)"
5.times do
  user = User.all.sample
  venue = Venue.all.sample
  date = Date.today + 7
  booking = Booking.new(
    start_date: date,
    end_date: date + 1
  )
  booking.user = user
  booking.venue = venue
  booking.save!
end

puts "creating reviews"
20.times do
  booking = Booking.all.sample
  review = Review.new(
    comment: Faker::Hipster.paragraph,
    rating: rand(1..5)
  )
  review.booking = booking
  review.save!
end

# -------------------- Jon's comments--------------------
# for the google API:
# we could pass other queries to this string in terms of location and search terms. I have also limited the number of results to 15.

# For checking the response and logic
# p music_venues.count

# music_venues.each do |music_venue|
#   puts "venue name:"
#   puts music_venue['name']
#   puts "-----------------------"
#   puts "address:"
#   puts music_venue['formatted_address']['']

# end

# puts music_venues.sample

# note: the api above also has google rating and opening hours, but i think we can leave these out for now.
# in addition, the api has a geometry field which has a location field which has lat and lng fields. I think we can use this to plot the venues on a map.
# docs https://developers.google.com/maps/documentation/places/web-service/search-text
# it may also be able to return photos, but i think we can leave this out for now.

# previous seeding --------------------

# def fetch_data(url)
#   JSON.parse(URI.open(url).read)
# end

# data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"].sample

# venue_description = fetch_data("https://dummyjson.com/posts")["posts"]
# venue_name = fetch_data("https://dummyjson.com/users")["users"]

# #-----CLEANING DB-----
# puts "destroying venue database"
# Venue.destroy_all

# puts "destroying user database"
# User.destroy_all

# puts "creating user database"
# 20.times do |u|
#   data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"][0]
#   user = User.new(
#     first_name: data['name']['first'],
#     last_name: data['name']['last'],
#     email: data['email'],
#     password: "banana",
#   )
#   user.save
#   puts "added user #{u}"
# end

# puts "user database seeded"

# #-----VENUE SEEDING-----
# # new_user_id = 1

# puts "creating venue database"
# 15.times do |v|
#   user = User.all.sample
#   venue_name = fetch_data("https://dummyjson.com/users")["users"].sample["company"]["name"]
# venue_description = fetch_data("https://dummyjson.com/posts")["posts"].sample["body"]
# data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"].sample

#   venue = Venue.new(
#     name: venue_name,
#     price_per_day: rand(50..100),
#     location: "#{data['location']['street']['name']}, #{data['location']['city']}",
#     size_of_band: rand(1..7),
#     description: venue_description,
#   )
#   # This line is crucial to associate the venue and user and allow for venues to be persisted.
#   venue.user = user
#   puts "associating users with venues"
#   p venue.user
#   # new_user_id += 1

#   venue.save!
#   puts "added venue #{v}"
# end

# puts "venue database seeded"
