# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'open-uri'
require 'json'

def fetch_data(url)
  JSON.parse(URI.open(url).read)
end

data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"][0]
venue_description = fetch_data("https://dummyjson.com/posts")["posts"]
venue_name = fetch_data("https://dummyjson.com/users")["users"]

#-----CLEANING DB-----
puts "destroying venue database"
Venue.destroy_all

puts "destroying user database"
User.destroy_all

puts "creating user database"
20.times do |u|
  data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"][0]
  user = User.new(
    first_name: data['name']['first'],
    last_name: data['name']['last'],
    email: data['email'],
    password: "banana",
    phone_number: data['cell']
  )
  user.save
  puts "added user #{u}"
end

puts "user database seeded"

#-----VENUE SEEDING-----
# new_user_id = 1

puts "creating venue database"
15.times do |v|
  user = User.first
  puts user
  venue_name = fetch_data("https://dummyjson.com/users")["users"][rand(1..30)]["company"]["name"]
  puts venue_name
  venue_description = fetch_data("https://dummyjson.com/posts")["posts"][rand(7..24)]["body"]
  venue = Venue.new(
    name: venue_name,
    price_per_day: rand(50..100),
    location: "#{data['location']['street']['name']}, #{data['location']['city']}",
    size_of_band: rand(1..7),
    description: venue_description,
  )
  venue.user = user
  # new_user_id += 1
  venue.save!
  puts "added venue #{v}"
end

puts "venue database seeded"
