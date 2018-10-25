class RecipesController < ApplicationController

def show
  @recipe = Recipe.find(params[:id])
  @receptions = Reception.where(recipe_id: @friend).all.order(:date)
# raise
end

def index
  @recipes = Recipe.where(user_id: current_user).all.order(:name)
end

def new
 @recipe = Recipe.new
end

def create
  @recipe = Recipe.new(recipes_params)
  @recipe.user = current_user
  if @recipe.save
  redirect_to recipes_path
  else
  render :new
  end
end

# --------------------------------------------------
# <a class="recipe-card-link" href="https://www.marmiton.org/magazine/diaporamiam_salon-du-chocolat_1.aspx">

#   <div class="recipe-card__picture">
#     <img src="https://images.marmitoncdn.org/pixcontent//70e30513-8902-4bf4-8c07-70d57b779a8f/befb2d6a-15c5-e5b6-7d7f-618bb01bce2b/feves_de_cacao_mortier_w350h250c1.jpg" alt="Article">
#     <ul class="recipe-card__tags">
#     </ul>
#   </div>

#   <div>
#     <h4 class="recipe-card__title">Salon du chocolat</h4>
#     <hr class="recipe-card__title-separator">
#     <p class="recipe-card__subtitle">Diaporamiam</p>
#     <div class="recipe-card__description">
#     Le Salon du <b>Chocolat</b> , rendez-vous des gourmands de tous âges ! Le <b>chocolat</b> y coule à flots, mais également lart , la finesse , la douceur , le talent des nombreux artisans...    </div>
#   </div>
# </a>
# -------------------------------------
# <a class="recipe-card-link" href="https://www.marmiton.org/recettes/recette_pave-au-chocolat_19099.aspx">

#   <div class="recipe-card__picture">
#     <img src="https://images.marmitoncdn.org/recipephotos/multiphoto/9e/9e36ad03-ae8d-4fa9-9bba-058be6ec2cce_w350h250c1.jpg" alt="Recipe">
#     <span class="recipe-card__add-to-notebook" data-recipe-title="Pavé au chocolat" data-recipe-thumbnail="https://images.marmitoncdn.org/recipephotos/multiphoto/9e/9e36ad03-ae8d-4fa9-9bba-058be6ec2cce_w350h250c1.jpg" data-recipe-id="19099">
#       <i class="icon-icon_heart"></i>
#     </span>
#     <ul class="recipe-card__tags">
#       <li class="mrtn-tag mrtn-tag--dark">Dessert</li>
#     </ul>
#   </div>

#   <div>
#     <h4 class="recipe-card__title">Pavé au chocolat</h4>
#     <hr class="recipe-card__title-separator">
#     <div class="recipe-card__rating">
#       <div class="mrtn-stars" data-mode="readonly"><span class="icon-star-full-active icon-icon_star_full mrtn-star"></span><span class="icon-star-full-active icon-icon_star_full mrtn-star"></span><span class="icon-star-full-active icon-icon_star_full mrtn-star"></span><span class="icon-star-full-active icon-icon_star_full mrtn-star"></span><span class="icon-star-full-active icon-icon_star_full mrtn-star"></span></div>
         # <div class="recipe-card__rating__score">
#       <span class="recipe-card__rating__value"> 5</span>&nbsp;<span class="recipe-card__rating__value__fract">/&nbsp;5</span>
#     </div>
#     <span class="mrtn-font-discret">sur 142 avis</span>
#   </div>
#   <div class="recipe-card__description">
#   <b>Ingrédients</b> : oeuf, farine, beurre, <b>chocolat</b>, sucre<br>Dans une casserole, faites fondre le <b>chocolat</b> et le beurre en morceaux. mélangez le sucre et les oeufs entiers, ajoutez le <b>chocolat</b>/beurre fondu...    </div>
#   <div class="recipe-card__duration">
#     <i class="icon-icon_time"></i>&nbsp; <span class="recipe-card__duration__value">25 min</span>
#   </div>
# </div>
# </a>
# -------------------------------------
# https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=curry-de-pois-chiche&start=1008

def open_file(url)
  # html_file = open(url).read
  return Nokogiri::HTML(open(url).read)
end

def suggestions

  require 'open-uri'
  @ingredient = params[:recipe][:name]
  url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@ingredient}"
  # html_file = open(url).read
  # html_doc = Nokogiri::HTML(html_file)
  html_doc = open_file(url)

  @suggestions = []
  index_recipes = 0
  nb_recipes = 0

  # on recupere le Nb de recettes à parser
  nb_recipes = html_doc.search('.recipe-search__nb-results')[0].text.split[0].to_i
 # raise
  # nb_page = nb_elements / 12
   boucle = true

   while (boucle)
    # boucle sur chaque page
    url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@ingredient}"+"&start=#{index_recipes}"
    html_doc = open_file(url)

    html_doc.search('.recipe-card-link').each do |element|
      # on ne selectinne que les fiches (donc recettes) qui sont notées
      if (element.search('.recipe-card__rating')[0] != nil)
        @suggestions << {
        link: element.attribute('href').value,
        title: element.search('.recipe-card__title')[0].text.strip,
        picture: element.search('.recipe-card__picture img').attribute('src').value
        }
      end
   end
   index_recipes += 12
   # boucle = false if (index_recipes >= nb_recipes)
   boucle = false if ((index_recipes >= nb_recipes) || (index_recipes > 500 ))

  end
  # &start=12

end

  private

  def recipes_params
    params.require(:recipe).permit(:name)
  end

end
