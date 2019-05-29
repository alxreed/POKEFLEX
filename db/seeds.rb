# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

Race.destroy_all



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
end

User.create!(
  email: "johnny@gmail.com", 
  password: "azerty", 
  first_name: "Johnny", 
  last_name: "Hallyday", 
  adress: "Heaven",
  remote_photo_url: "https://gal.img.pmdstatic.net/fit/http.3A.2F.2Fprd2-bone-image.2Es3-website-eu-west-1.2Eamazonaws.2Ecom.2Fgal.2F2018.2F02.2F22.2Fa2ff4515-a7b6-44b2-87f3-9454d1c3623d.2Ejpeg/480x480/quality/80/a-st-barth-johnny-hallyday-n-avait-pas-fini-de-payer-les-travaux-de-la-villa-jade.jpg"
)

puts 'creating users..(may take some time'
20.times do
  User.create!(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email, adress: Faker::Address.city, password: "12345678", remote_photo_url: "https://i.pravatar.cc/300" )
  print "#"
end

puts "creating pokemons gotta catch 'em all !"
300.times do
  Pokemon.create!(name: Faker::Name.first_name, level: rand(1..100), price: rand(50..1500), user: User.all.sample, race: Race.all.sample)
  print "#"
end

700.times do
  Review.create!(content: Faker::Lorem.paragraph(4), rating: rand(1..5), user: User.all.sample, pokemon: Pokemon.all.sample)
  print "#"
end

puts "ok"