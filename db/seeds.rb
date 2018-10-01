# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destruction des tables users, recipes, friends, receptions"

User.destroy_all
Recipe.destroy_all
Friend.destroy_all
Reception.destroy_all

puts " lancement des seeds"

user1 = User.create(
    email: 'user1@gmail.com',
    password: 'password',
    password_confirmation: 'password'
  )
recipe1 = Recipe.create(
    name: "Choucroute" ,
    link: "" ,
    description: "description complete de la choucroute" ,
    user: user1
  )
friend1 = Friend.create(
    name: "Ugo et Magali" ,
    email: 'ugo@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
reception1 = Reception.create(
    date: DateTime.new(2018,2,3),
    friend: friend1 ,
    recipe: recipe1
  )
puts "seeds terminés"
