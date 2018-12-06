class RecipesController < ApplicationController

def show
  @recipe = Recipe.find(params[:id])
  @receptions = Reception.where(recipe_id: @friend).all.order(:date)

end

def index
  #@recipes = Recipe.where(user_id: current_user).all.order(:name)
@recipes = Recipe.where(user_id: current_user).all.order(:created_at).reverse

end

def new
 @recipe = Recipe.new
 @items = []
 @items[0] = "Marmiton"
 @items[1] = "750g.   "
end

def search
@recipe = Recipe.new
 @items = []
 @items[0] = "Marmiton"
 @items[1] = "750g.   "
end

def create

# on crée recette marmiton ou 750g issue du SEARCH
if params[:_method] == "post"

  @search_recipe = params[:recipe][:name]
  # si recette saisie vide Pb
  if @search_recipe == ""
    @recipe = Recipe.new
    @items = []
    @items[0] = "Marmiton"
    @items[1] = "750g.   "
    render :search
  # sinon on ajoute la recette saisie, pas de lien vers un site cuisine
  #
  else

    @recipe = Recipe.new(recipes_params)

    @recipe.user = current_user
    @recipe.photo = ""
    @recipe.photoexist = false
    @recipe.description = ""
    @recipe.ingredient = ""
    #on parcourt les ingredients
    params[:recipe][:ingredients].each_with_index do | ingredient , index|
      @recipe.ingredient += "-> #{ingredient}\n"
    end

    if @recipe.save
      redirect_to recipes_path
    else
      render :search
    end
  end


# on crée recette interne issue du AJOUTER
else

    @search_recipe = params[:recipe][:name]
    @search_description = params[:recipe][:description]
    @search_photo = params[:recipe][:photo]
    @photoexist = true
    if @search_photo.nil?
      @search_photo = ""
      @photoexist = false
    end

    # si recette saisie vide Pb
    if @search_recipe == ""
      @recipe = Recipe.new
      @items = []
      @items[0] = "Marmiton"
      @items[1] = "750g.   "
      render :new
    # sinon on ajoute la recette saisie, pas de lien vers un site cuisine
    #
    else

      @recipe = Recipe.new(recipes_params)
      @recipe.user = current_user
      @recipe.logo =  "moi"
      @recipe.link =  ""
      @recipe.image =  ""
      @recipe.photo = @search_photo
      @recipe.photoexist = @photoexist
      if @recipe.save
        redirect_to recipes_path
      else
        render :new
      end
    end
end

end
#ANCIENNE VERSION
def createBACK
  raise
  @recipe = Recipe.new(recipes_params)
  @recipe.user = current_user
  @recipe.photo = ""
  @recipe.photoexist = false
  @recipe.description = ""

  if @recipe.save
    redirect_to recipes_path
  else
    render :new
  end
end


def destroy

  @recipe = Recipe.find(params[:id])
  @recipe.destroy
  redirect_to recipes_path
end

def open_file(url)
  return Nokogiri::HTML(open(url).read)
end

#END ANCIENNE VERSION

def suggestions

  # DEBUT MARMITON
  require 'open-uri'
  require 'recipe_scraper'

  @search_recipe = params[:recipe][:name]
  @search_provider = params[:items]
  @search_provider.delete_if(&:blank?)
  @suggestions = []


# si recette saisie vide ou pas de site saisi
  if @search_recipe == "" || @search_provider.length == 0
    # si recette saisie vide Pb
      @recipe = Recipe.new
      @items = []
      @items[0] = "Marmiton"
      @items[1] = "750g.   "
      render :search

  else

    #DEBUT MARMITON
    if @search_provider.include? "0"

      url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@search_recipe}"
      html_doc = open_file(url)

      # on recupere le Nb de recettes à parser
      nb_recipes = 0

      if (html_doc.search('.recipe-search__nb-results')[0] == nil)

        @recipe = Recipe.new
        @items = []
        @items[0] = "Marmiton"
        @items[1] = "750g.   "
        render :new
      else

          nb_recipes = html_doc.search('.recipe-search__nb-results')[0].text.split[0].to_i

           # boucle sur chaque page
           boucle = true
           index_recipes = 0
           while (boucle)
            url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@search_recipe}"+"&start=#{index_recipes}"
            html_doc = open_file(url)

            html_doc.search('.recipe-card-link').each do |element|
              # on ne selectinne que les fiches (donc recettes) qui sont notées

              if (element.search('.recipe-card__rating')[0] != nil)

                #Test si link=>"/recettes/recette_fajitas-au-poulet-au-curry_359710.aspx"
                #alors on complete avec www.marmiton

                p = element.attribute('href').value.strip.match(/^https/)
                if (p == nil)
                  link_recipe = "https://www.marmiton.org" + element.attribute('href').value
                else
                  link_recipe = element.attribute('href').value
                end
                # on supprime le s de https sinon RecipeScraper plante
                link_recipe.slice!(4)

                marmiton_url = 'http://www.marmiton.org/recettes/recette_burger-d-avocat_345742.aspx'

                recipe = RecipeScraper::Recipe.new link_recipe



# will return recipe.to_hash
# --------------
# { :cooktime => 7,
#        :image => "http://images.marmitoncdn.org/recipephotos/multiphoto/7b/7b4e95f5-37e0-4294-bebe-cde86c30817f_normal.jpg",
#        :© => ["2 beaux avocat", "2 steaks hachés de boeuf", "2 tranches de cheddar", "quelques feuilles de salade", "1/2 oignon rouge", "1 tomate", "graines de sésame", "1 filet d'huile d'olive", "1 pincée de sel", "1 pincée de poivre"],
#        :preptime => 20,
#        :steps => ["Laver et couper la tomate en rondelles", "Cuire les steaks à la poêle avec un filet d'huile d'olive", "Saler et poivrer", "Toaster les graines de sésames", "Ouvrir les avocats en 2, retirer le noyau et les éplucher", "Monter les burger en plaçant un demi-avocat face noyau vers le haut, déposer un steak, une tranche de cheddar sur le steak bien chaud pour qu'elle fonde, une rondelle de tomate, une rondelle d'oignon, quelques feuilles de salade et terminer par la seconde moitié d'avocat", "Parsemer quelques graines de sésames."],
#        :title => "Burger d'avocat",
#  }


                @suggestions << {
                link: link_recipe ,
                name: element.search('.recipe-card__title')[0].text.strip,
                picture: element.search('.recipe-card__picture img').attribute('src').value,
                logo: "M",
                ingredients:recipe.to_hash[:ingredients],
                }
              end #end if
            end #each do element
           index_recipes += 12
          # on s'arrete aux 3 premieres pages
           boucle = false if ((index_recipes >= nb_recipes) || (index_recipes > 3 ))
          end #while boucle

      end #else if (html_doc.search('.recipe-search__nb-results')[0] == nil)
      # FIN MARMITON
    end #if @search_provider.include? "0"
  #DEBUT 750gr

  if @search_provider.include? "1"
    url = "https://www.750g.com/recherche.htm?search=#{@search_recipe}"
    html_doc = open_file(url)
    # on recupere le Nb de recettes à parser
    nb_recipes = 0

    html_doc.search('.u-title-section').each do |element|
      if element.text.strip.match(/(\d{1,5})/) != nil
            nb_recipes = element.text.strip.match(/(\d{1,5})/)[1].to_i
      end
    end # each do
    if (nb_recipes == 0)
      @recipe = Recipe.new
      @items = []
      @items[0] = "Marmiton"
      @items[1] = "750g.   "
      render :new
    else

       # boucle sur chaque page
       boucle = true
       borne_index = nb_recipes / 10
       index_recipes = 1

       while (boucle)
        url = "https://www.750g.com/recherche.htm?search=#{@search_recipe}&page=#{index_recipes}"
        html_doc = open_file(url)

        html_doc.search('.c-recipe-row').each do |element|
          # on ne selectinne que les fiches (donc recettes)
          # if (element.search('.recipe-card__rating')[0] != nil)
            @suggestions << {
            link: "https://www.750g.com" + element.search('.c-recipe-row__title a').attribute('href').value,
            name: element.search('.c-recipe-row__title a')[0].text.strip,
            picture: element.search('.c-recipe-row__media img').attribute('data-src').value,
            logo: "750",
            ingredients:[""],
            }
          # end #end if
        end #each do element
       index_recipes += 1

       boucle = false if ((index_recipes >= borne_index) || (index_recipes > 3 ))
      end #while boucle
    end # else  if (nb_recipes == 0)
   end #end  if @search_provider.include? "1"
  end # else  @search_recipe == "" || @search_provider.length == 0

end










#ANCIENNE VERSION
def suggestionsBACKUP


  # DEBUT MARMITON
  require 'open-uri'
  @search_recipe = params[:recipe][:name]
  @search_photo = params[:recipe][:photo]
  @photoexist = true
  if @search_photo.nil?
    @search_photo = ""
    @photoexist = false
  end
  @search_description = params[:recipe][:description]


  @search_provider = params[:items]
  @search_provider.delete_if(&:blank?)
  @suggestions = []


# si recette saisie vide ou pas de site saisi
  if @search_recipe == "" || @search_provider.length == 0
    # si recette saisie vide Pb
    if @search_recipe == ""
      @recipe = Recipe.new
      @items = []
      @items[0] = "Marmiton"
      @items[1] = "750g.   "
      render :new
    # sinon on ajoute la recette saisie, pas de lien vers un site cuisine
    #
    else

    recipe = Recipe.create!(
        name: @search_recipe ,
        logo: "moi",
        link: "" ,
        description: "#{@search_description}" ,
        image: "",
        user: current_user,
        photo: @search_photo,
        photoexist: @photoexist
      )

    # recipe = Recipe.new(name: @search_recipe, logo: "moi", link: ""  ,  description:  "#{@search_description}" ,
    #    image: "",user: current_user, photo:@search_photo)

    # recipe.save

    redirect_to recipes_path
    end
  else
    #DEBUT MARMITON
    if @search_provider.include? "0"

      url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@search_recipe}"
      html_doc = open_file(url)

      # on recupere le Nb de recettes à parser
      nb_recipes = 0

      if (html_doc.search('.recipe-search__nb-results')[0] == nil)

        @recipe = Recipe.new
        @items = []
        @items[0] = "Marmiton"
        @items[1] = "750g.   "
        render :new
      else

          nb_recipes = html_doc.search('.recipe-search__nb-results')[0].text.split[0].to_i

           # boucle sur chaque page
           boucle = true
           index_recipes = 0
           while (boucle)
            url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@search_recipe}"+"&start=#{index_recipes}"
            html_doc = open_file(url)

            html_doc.search('.recipe-card-link').each do |element|
              # on ne selectinne que les fiches (donc recettes) qui sont notées

              if (element.search('.recipe-card__rating')[0] != nil)

                #Test si link=>"/recettes/recette_fajitas-au-poulet-au-curry_359710.aspx"
                #alors on complete avec www.marmiton

                p = element.attribute('href').value.strip.match(/^https/)
                if (p == nil)
                  link_recipe = "https://www.marmiton.org" + element.attribute('href').value
                else
                  link_recipe = element.attribute('href').value
                end
                @suggestions << {
                link: link_recipe ,
                name: element.search('.recipe-card__title')[0].text.strip,
                picture: element.search('.recipe-card__picture img').attribute('src').value,
                logo: "M"

                }
              end #end if
            end #each do element
           index_recipes += 12
          # on s'arrete aux 3 premieres pages
           boucle = false if ((index_recipes >= nb_recipes) || (index_recipes > 3 ))
          end #while boucle

      end #else if (html_doc.search('.recipe-search__nb-results')[0] == nil)
      # FIN MARMITON
    end #if @search_provider.include? "0"
  #DEBUT 750gr

  if @search_provider.include? "1"
    url = "https://www.750g.com/recherche.htm?search=#{@search_recipe}"
    html_doc = open_file(url)
    # on recupere le Nb de recettes à parser
    nb_recipes = 0

    html_doc.search('.u-title-section').each do |element|
      if element.text.strip.match(/(\d{1,5})/) != nil
            nb_recipes = element.text.strip.match(/(\d{1,5})/)[1].to_i
      end
    end # each do
    if (nb_recipes == 0)
      @recipe = Recipe.new
      @items = []
      @items[0] = "Marmiton"
      @items[1] = "750g.   "
      render :new
    else

       # boucle sur chaque page
       boucle = true
       borne_index = nb_recipes / 10
       index_recipes = 1

       while (boucle)
        url = "https://www.750g.com/recherche.htm?search=#{@search_recipe}&page=#{index_recipes}"
        html_doc = open_file(url)

        html_doc.search('.c-recipe-row').each do |element|
          # on ne selectinne que les fiches (donc recettes)
          # if (element.search('.recipe-card__rating')[0] != nil)
            @suggestions << {
            link: "https://www.750g.com" + element.search('.c-recipe-row__title a').attribute('href').value,
            name: element.search('.c-recipe-row__title a')[0].text.strip,
            picture: element.search('.c-recipe-row__media img').attribute('data-src').value,
            logo: "750"
            }
          # end #end if
        end #each do element
       index_recipes += 1

       boucle = false if ((index_recipes >= borne_index) || (index_recipes > 3 ))
      end #while boucle
    end # else  if (nb_recipes == 0)
   end #end  if @search_provider.include? "1"
  end # else  @search_recipe == "" || @search_provider.length == 0

end
#END ANCIENNE VERSION


  private

  def recipes_params
    params.require(:recipe).permit(:name, :photo, :logo, :link, :description, :image, :user, :photo, :photoexist, :ingredients )
  end

end











