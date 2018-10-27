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


def open_file(url)
  return Nokogiri::HTML(open(url).read)
end

def suggestions
  # DEBUT MARMITON
  require 'open-uri'
  @ingredient = params[:recipe][:name]
  url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@ingredient}"
  html_doc = open_file(url)

  # on recupere le Nb de recettes à parser
  nb_recipes = 0
  nb_recipes = html_doc.search('.recipe-search__nb-results')[0].text.split[0].to_i
 # raise

   # boucle sur chaque page
   boucle = true
   index_recipes = 0
   @suggestions = []
   while (boucle)

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

   boucle = false if ((index_recipes >= nb_recipes) || (index_recipes > 5 ))

  end
  # FIN MARMITON

end

  private

  def recipes_params
    params.require(:recipe).permit(:name)
  end

end
