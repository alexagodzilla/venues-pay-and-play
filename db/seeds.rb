require 'date'
require 'open-uri'
require 'json'

# need to source google alternative as api key expired - mapbox?

#-----GOOGLE API-----
url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=music%20rehearsal%20venues%20in%20London&photo_reference=true&limit=20&key=#{ENV.fetch('GOOGLE_API_KEY')}"
music_venues = JSON.parse(URI.open(url).read)['results']

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
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.first_name}@#{Faker::Name.last_name}.com",
    password: "123456"
  )
  user.save!
end

puts "creating venues"
venue_images = %w[
  https://static.wixstatic.com/media/1f8cd9_848e822606804a9da2a34d1aae56bf23~mv2.jpg/v1/fill/w_4032,h_1113,al_c,q_90,enc_auto/1f8cd9_848e822606804a9da2a34d1aae56bf23~mv2.jpg
  https://static.wixstatic.com/media/bdfdb4_f3bd3124c6c941baaa09e331ebc240fc~mv2.jpg/v1/fill/w_1024,h_768,al_c,q_85,enc_auto/bdfdb4_f3bd3124c6c941baaa09e331ebc240fc~mv2.jpg
  https://static.wixstatic.com/media/bdfdb4_a2dedef51ee74dd89063261f5c469f4b~mv2.jpg/v1/fill/w_1024,h_768,al_c,q_85,enc_auto/bdfdb4_a2dedef51ee74dd89063261f5c469f4b~mv2.jpg
  https://static.wixstatic.com/media/1f8cd9_690aeae5fc92476299a2728a73087e56~mv2.jpg/v1/fill/w_4032,h_1113,al_c,q_90,enc_auto/1f8cd9_690aeae5fc92476299a2728a73087e56~mv2.jpg
  https://static.wixstatic.com/media/bdfdb4_11e7a5c2a305422aa352e88b78d6af05~mv2_d_7052_3856_s_4_2.jpg/v1/fill/w_1856,h_1018,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/bdfdb4_11e7a5c2a305422aa352e88b78d6af05~mv2_d_7052_3856_s_4_2.jpg
  https://static.wixstatic.com/media/bdfdb4_77769fd18b1d497ea33f44a351e4d00f~mv2.jpg/v1/fill/w_1212,h_804,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/bdfdb4_77769fd18b1d497ea33f44a351e4d00f~mv2.jpg
  https://superunisonstudios.files.wordpress.com/2014/04/sugigposter160917.jpg
  https://i0.wp.com/www.premisesstudios.com/wp-content/uploads/2015/10/rehearshal-studio_london.jpg?fit=825%2C484&ssl=1
  https://static.wixstatic.com/media/fe114a_4b32431a85964fa992ddf4b2e16e98db~mv2.jpg/v1/fill/w_776,h_506,al_c,q_85,usm_0.66_1.00_0.01,enc_auto/fe114a_4b32431a85964fa992ddf4b2e16e98db~mv2.jpg
  https://images.squarespace-cdn.com/content/v1/5eb149b68f23d941de5da0fd/1591612019862-1U39REUBIWRVN0TCGOIV/Studio%2B1.jpg?format=1500w
  https://millhillmusiccomplex.co.uk/wp-content/uploads/2013/08/Studio-2-1-1.jpg
  https://millhillmusiccomplex.co.uk/wp-content/uploads/2013/08/Studio4-3.jpg
  https://millhillmusiccomplex.co.uk/wp-content/uploads/2013/08/Studio-8-room-scaled-405x304.jpg
  https://www.residentstudios.com/wp-content/uploads/2019/03/IMG_3958c2.jpg
  https://www.residentstudios.com/wp-content/uploads/2017/02/IMG_1678.jpg
]

music_venues.each do |venue_api|
  user = User.all.sample
  venue = Venue.new(
    name: venue_api['name'],
    price_per_day: rand(75..150),
    location: venue_api['formatted_address'].split(', United Kingdom')[0],
    size_of_band: rand(3..10),
    phone_number: "07#{rand(10**9)}",
    description: Faker::Hipster.paragraph,
    latitude: venue_api["geometry"]["location"]["lat"],
    longitude: venue_api["geometry"]["location"]["lng"],
    pic_url:
    venue_api['photos'].nil? ? venue_images.sample : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photoreference=#{venue_api['photos'][0]['photo_reference']}&key=#{ENV.fetch('GOOGLE_API_KEY')}"
  )
  venue.user = user
  venue.save!
end

puts "creating bookings - 15"
available_venues = Venue.all.first(15)
available_venues.each do |venue|
  user = User.all.sample
  date = Date.today + rand(5..25)
  booking = Booking.new(start_date: date, end_date: date + 1)
  booking.user = user
  booking.venue = venue
  booking.save!
end

puts "creating bookings - 5 (with same date)"
unavailable_venues = Venue.all.last(5)
unavailable_venues.each do |venue|
  user = User.all.sample
  date = Date.today + 7
  booking = Booking.new(start_date: date, end_date: date + 1)
  booking.user = user
  booking.venue = venue
  booking.save!
end

puts "creating reviews"
75.times do
  booking = Booking.all.sample
  review = Review.new(
    comment: Faker::TvShows::TheFreshPrinceOfBelAir.quote,
    rating: rand(3..5)
  )
  review.booking = booking
  review.save!
end
