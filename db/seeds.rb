# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
puts "destruction des tables users, recipes, friends, receptions, admin"

Reception.destroy_all
User.destroy_all
AdminUser.destroy_all
Recipe.destroy_all
Friend.destroy_all


puts " lancement des seeds"

user1 = User.create(
    email: 'user1@gmail.com',
    password: 'password',
    password_confirmation: 'password',


  )
adminuser = AdminUser.create(
    email: 'admin@gmail.com',
    password: 'password',
    password_confirmation: 'password',

  )

  # create_table "admin_users", force: :cascade do |t|
  #   t.string "email", default: "", null: false
  #   t.string "encrypted_password", default: "", null: false
  #   t.string "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["email"], name: "index_admin_users_on_email", unique: true
  #   t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  # end


  # create_table "users", force: :cascade do |t|
  #   t.string "email", default: "", null: false
  #   t.string "encrypted_password", default: "", null: false
  #   t.string "reset_password_token"
  #   t.datetime "reset_password_sent_at"
  #   t.datetime "remember_created_at"
  #   t.datetime "created_at", null: false
  #   t.datetime "updated_at", null: false
  #   t.index ["email"], name: "index_users_on_email", unique: true
  #   t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  # end

















recipe11 = Recipe.create(
    name: "Choucroute" ,
    logo: "M",
    link: "https://www.marmiton.org/recettes/recette_choucroute_20312.aspx" ,
    description: "description complete de la choucroute " ,
    image: "https://images.marmitoncdn.org/recipephotos/multiphoto/8c/8c447c04-7792-45e4-91ca-9f5761a7e6cc_w350h250c1.jpg",
    user: user1
  )
recipe12 = Recipe.create(
    name: "Poulet citron" ,
    logo: "M",
    link: "https://www.marmiton.org/recettes/recette_poulet-a-la-coriandre-et-citron-vert_166524.aspx" ,
    description: "description complete du poulet au citron usr1, 1. acheter un beau poulet 2. le deplumer 3. le couper 4. le faire cuire casserole 4. ajouter sel et poivre 5. mijoter 20minutes" ,
    image: "https://images.marmitoncdn.org/recipephotos/multiphoto/88/88cd2ecb-1bda-4570-98ee-a64082ffe973_w350h250c1.jpg",
    user: user1
  )
recipe13 = Recipe.create(
    name: "Cabillaud purée" ,
    logo: "M",
    link: "https://www.marmiton.org/recettes/recette_dos-de-cabillaud-tout-simple_72532.aspx" ,
    description: "description complete du cabillaud purée " ,
    image: "https://images.marmitoncdn.org/recipephotos/multiphoto/a9/a927e657-825f-49b8-8dfa-7585a8b8fa7b_w350h250c1.jpg",
    user: user1
  )
recipe14 = Recipe.create(
    name: "Moule frite" ,
    logo: "M",
    link: "https://www.marmiton.org/recettes/recette_moules-frites-et-non-avec-des-pommes-frites_332938.aspx" ,
    description: "description complete Moule frite " ,
    image: "https://images.marmitoncdn.org/recipephotos/multiphoto/0c/0c3fc5cf-6f24-4692-8c43-a62661293439_w350h250c1.jpg",
    user: user1
  )
recipe15 = Recipe.create(
    name: "Pizza royale" ,
    logo: "750",
    link: "https://www.750g.com/pizza-royale-au-barbecue-r75180.htm" ,
    description: "description complete Pizza " ,
    image: "https://static.750g.com/images/622-auto/b4d093dd2bffa8972341596dfc693999/pizza-royale-au-barbecue.jpeg",
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
reception15 = Reception.create(
    date: DateTime.new(2018,2,2),
    friend: friend11 ,
    recipe: recipe15
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
# friend21 = Friend.create(
#     name: "Ugo et Magali user2" ,
#     email: 'ugo@gmail.com',
#     telephone: "0622456789" ,
#     user: user2
#   )
# friend22 = Friend.create(
#     name: "Tonio et Fatou user2" ,
#     email: 'tonio@gmail.com',
#     telephone: "0622456789" ,
#     user: user2
#   )
# friend23 = Friend.create(
#     name: "Marie et Loic user2" ,
#     email: 'marie@gmail.com',
#     telephone: "0622456789" ,
#     user: user2
#   )
# reception21 = Reception.create(
#     date: DateTime.new(2018,2,3),
#     friend: friend21 ,
#     recipe: recipe21
#   )
# reception22 = Reception.create(
#     date: DateTime.new(2018,2,3),
#     friend: friend21 ,
#     recipe: recipe22
#   )
puts "seeds terminés"
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?
