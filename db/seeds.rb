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
    description: "description complete de la choucroute " ,
    user: user1
  )
recipe12 = Recipe.create(
    name: "Poulet citron user1" ,
    link: "" ,
    description: "description complete du poulet au citron usr1, 1. acheter un beau poulet 2. le deplumer 3. le couper 4. le faire cuire casserole 4. ajouter sel et poivre 5. mijoter 20minutes" ,
    user: user1
  )
recipe13 = Recipe.create(
    name: "Cabillaud purée user1" ,
    link: "" ,
    description: "description complete du cabillaud purée " ,
    user: user1
  )
recipe14 = Recipe.create(
    name: "Moule frite user1" ,
    link: "" ,
    description: "description complete Moule frite " ,
    user: user1
  )
friend11 = Friend.create(
    name: "Ugo et Magali " ,
    email: 'ugo@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
friend12 = Friend.create(
    name: "Tonio et Fatou " ,
    email: 'tonio@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
friend13 = Friend.create(
    name: "Marie et Loic " ,
    email: 'marie@gmail.com',
    telephone: "0622456789" ,
    user: user1
  )
reception11 = Reception.create(

    date: DateTime.new(2018,4,6),
    friend: friend11 ,
    recipe: recipe11
  )
reception12 = Reception.create(
    date: DateTime.new(2018,2,4),
    friend: friend11 ,
    recipe: recipe12
  )

reception13 = Reception.create(
    date: DateTime.new(2018,3,5),
    friend: friend11 ,
    recipe: recipe13
  )
reception14 = Reception.create(
    date: DateTime.new(2018,1,3),
    friend: friend11 ,
    recipe: recipe14
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
