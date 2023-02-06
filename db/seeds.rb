# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# require 'open-uri'
# require 'json'

# data = JSON.parse(URI.open("https://randomuser.me/api/?results=15&nat=gb").read)["results"][0]
# venue_description = JSON.parse(URI.open("https://dummyjson.com/posts").read)["posts"]
# venue_name = JSON.parse(URI.open("https://dummyjson.com/users").read)["users"]

# #-----USER SEEDING-----
# puts "destroying user database"
# User.destroy_all

# puts "creating user database"
# 20.times do
#   user = User.new(
#     first_name: data['name']['first'],
#     last_name: data['name']['last'],
#     email: data['email'],
#     password: "banana"
#   )
#   user.save
# end

# puts "user database seeded"

# #-----VENUE SEEDING-----
# new_user_id = 1

# puts "destroying venue database"
# Venue.destroy_all

# puts "creating venue database"
# 15.times do
#   venue = Venue.new(
#     name: venue_name["company"]["name"],
#     price_per_day: rand(50..100),
#     location: "#{data['location']['street']['name']}, #{data['location']['city']}",
#     size_of_band: rand(1..7),
#     description: venue_description[rand(7..24)]["body"],
#     phone_number: data['cell'],
#     user_id: new_user_id
#   )
#   new_user_id += 1
#   venue.save
# end

# puts "venue database seeded"
