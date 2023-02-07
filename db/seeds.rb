# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# The API logic below almost works but generates a lot of identical records, and all the addresses are the same. If there is a missing field the database seeding crashes. I think this could perhaps be fixed but for now, to reach MVP i agree t just use faker.

require 'open-uri'
require 'json'

def fetch_data(url)
  JSON.parse(URI.open(url).read)
end

data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"].sample

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
  )
  user.save
  puts "added user #{u}"
end

puts "user database seeded"

#-----VENUE SEEDING-----
# new_user_id = 1

puts "creating venue database"
15.times do |v|
  user = User.all.sample
  venue_name = fetch_data("https://dummyjson.com/users")["users"].sample["company"]["name"]
venue_description = fetch_data("https://dummyjson.com/posts")["posts"].sample["body"]
data = fetch_data("https://randomuser.me/api/?results=15&nat=gb")["results"].sample

  venue = Venue.new(
    name: venue_name,
    price_per_day: rand(50..100),
    location: "#{data['location']['street']['name']}, #{data['location']['city']}",
    size_of_band: rand(1..7),
    description: venue_description,
  )
  # This line is crucial to associate the venue and user and allow for venues to be persisted.
  venue.user = user
  puts "associating users with venues"
  p venue.user
  # new_user_id += 1

  venue.save!
  puts "added venue #{v}"
end

puts "venue database seeded"
