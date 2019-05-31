# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

puts "Destroying all..."
Review.destroy_all
Rental.destroy_all
Pokemon.destroy_all
Race.destroy_all
User.destroy_all


puts "Creating Races..."

url = "https://pokeapi.co/api/v2/pokemon/"
image_url = "https://www.serebii.net/pokemongo/pokemon/"
# sprintf('%03d', number)
image_url2 = "https://img.pokemondb.net/artwork/"


(1..151).each do |number|
  location = ["Pallet Town", "Viridian City", "Pewter City", "Cerulean City", "Vermilion City", "Lavender Town", "Celadon City", "Fuschia City", "Saffron City", "Cinnabar Island"]
  pokemon_url = open("#{url}#{number}").read
  pokemon = JSON.parse(pokemon_url)
  photo = image_url2 + pokemon["name"] + ".jpg"
  Race.create!(name: pokemon["name"], category: pokemon["types"][0]["type"]["name"], location: location.sample, photo: photo)
  print "#"
end
puts ""

puts "Creating Johnny..."

User.create!(
  email: "johnny@gmail.com", 
  password: "azerty", 
  first_name: "Johnny", 
  last_name: "Hallyday", 
  adress: "Heaven",
  remote_photo_url: "https://gal.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fgal.2F2018.2F02.2F22.2Fa2ff4515-a7b6-44b2-87f3-9454d1c3623d.2Ejpeg/480x480/quality/80/a-st-barth-johnny-hallyday-n-avait-pas-fini-de-payer-les-travaux-de-la-villa-jade.jpg"
)
print "#"
puts ""

puts 'Creating users(may take some time)...'
10.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, adress: Faker::Address.city, password: "azerty", remote_photo_url: "https://i.pravatar.cc/300" )
  print "#"
end
puts ""

puts "Creating pikachus"
Pokemon.create!(name: "Mouad", level: 10, hp: 345, attack: 56, defense: 23, special_attack: 87, special_defense: 45, speed: 59, price: 89, user: User.all.sample, race: Race.find_by_name("pikachu"))
print "#"

Pokemon.create!(name: "Alex", level: 89, hp: 4345, attack: 86, defense: 43, special_attack: 97, special_defense: 55, speed: 99, price: 889, user: User.all.sample, race: Race.find_by_name("pikachu"))
print "#"
puts ""

puts "Creating pokemons, gotta catch 'em all !"
300.times do
  level = rand(10..100)
  Pokemon.create!(name: Faker::Name.first_name, level: level, hp: level * 127, attack: level + rand(-9..9), defense: level + rand(-9..9), special_attack: level + rand(-9..9), special_defense: level + rand(-9..9), speed: level + rand(-9..9), price: level * 13, user: User.all.sample, race: Race.all.sample)
  print "#"
end
puts ""


puts "creating reviews..." 

700.times do
  comment = ["Really good pokemon!", "Bad pokemon", "I lost my fight...", "This pokemon is super strong !", "Thank you pokeflex !", "I wanted to try this pokemon for a long time, thank you !", "I didn't win but i had a really nice time with this pokemon", "I am really dispapointed with this pokemon"]
  Review.create!(content: Faker::Lorem.paragraph(4), rating: rand(1..5), user: User.all.sample, pokemon: Pokemon.all.sample)
  print "#"
end
puts "#"  

puts "seed completed !"