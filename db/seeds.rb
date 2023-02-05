# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

data = JSON.parse(URI.open("https://randomuser.me/api/?results=15&nat=gb").read)["results"][0]
# the user details are set to nationality GB, so phone numbers start with '07' and addresses are in the UK
venue_description = JSON.parse(URI.open("https://dummyjson.com/posts").read)["posts"]
venue_name = JSON.parse(URI.open("https://dummyjson.com/users").read)["users"]

#-----USER SEEDING-----
puts "destroying user database"
User.destroy_all

puts "creating user database"
20.times do |u|
  user = User.new(
    first_name: data['name']['first'],
    last_name: data['name']['last'],
    email: data['email'],
    password: "banana",
    phone_number: data['cell']
  )
  user.save
  puts "added user #{u.id}"
end

puts "user database seeded"

#-----VENUE SEEDING-----
new_user_id = 1

puts "destroying venue database"
Venue.destroy_all

puts "creating venue database"
15.times do |v|
  venue = Venue.new(
    name: venue_name[rand(1..30)]["company"]["name"],
    price_per_day: rand(50..100),
    location: "#{data['location']['street']['name']}, #{data['location']['city']}",
    size_of_band: rand(1..7),
    description: venue_description[rand(7..24)]["body"],
    # does the logic for user_id look ok? we need to assign a user_id for each venue and as we'll have 8 users,
    # i want to cycle through numbers 1 to 8. i called it new_user_id as squiggly lines didn't like just user_id
    user_id: new_user_id
  )
  new_user_id += 1
  venue.save
  puts "added venue #{v.id}"
end

puts "venue database seeded"
