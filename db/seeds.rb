# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destruction des tables users, recipes, friends, receptions"

Reception.destroy_all
User.destroy_all
Recipe.destroy_all
Friend.destroy_all


puts " lancement des seeds"

user1 = User.create(
    email: 'user1@gmail.com',
    password: 'password',
    password_confirmation: 'password'
  )

recipe11 = Recipe.create(
    name: "Choucroute user1" ,
    link: "" ,
    description: "description complete de la choucroute user1" ,
    user: user1
  )
recipe12 = Recipe.create(
    name: "Poulet citron user1" ,
    link: "" ,
    description: "description complete du poulet au citron user1" ,
    user: user1
  )
friend11 = Friend.create(
    name: "Ugo et Magali user1" ,
    email: 'ugo@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
friend12 = Friend.create(
    name: "Tonio et Fatou user1" ,
    email: 'tonio@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
friend13 = Friend.create(
    name: "Marie et Loic user1" ,
    email: 'marie@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
reception11 = Reception.create(
    date: DateTime.new(2018,2,3),
    friend: friend11 ,
    recipe: recipe11
  )
reception12 = Reception.create(
    date: DateTime.new(2018,2,3),
    friend: friend11 ,
    recipe: recipe12
  )


user2 = User.create(
    email: 'user2@gmail.com',
    password: 'password',
    password_confirmation: 'password'
  )
recipe21 = Recipe.create(
    name: "Choucroute user2" ,
    link: "" ,
    description: "description complete de la choucroute user2" ,
    user: user2
  )
recipe22 = Recipe.create(
    name: "Poulet citron user2" ,
    link: "" ,
    description: "description complete du poulet au citron user2" ,
    user: user2
  )
friend21 = Friend.create(
    name: "Ugo et Magali user2" ,
    email: 'ugo@gmail.com',
    telephone: "0622456789" ,
    user: user2
  )
friend22 = Friend.create(
    name: "Tonio et Fatou user2" ,
    email: 'tonio@gmail.com',
    telephone: "0622456789" ,
    user: user2
  )
friend23 = Friend.create(
    name: "Marie et Loic user2" ,
    email: 'marie@gmail.com',
    telephone: "0622456789" ,
    user: user2
  )
reception21 = Reception.create(
    date: DateTime.new(2018,2,3),
    friend: friend21 ,
    recipe: recipe21
  )
reception22 = Reception.create(
    date: DateTime.new(2018,2,3),
    friend: friend21 ,
    recipe: recipe22
  )
puts "seeds terminés"
