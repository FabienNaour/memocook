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
 @items = []
 @items[0] = "Marmiton"
 @items[1] = "750g"
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

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

def open_file(url)
  return Nokogiri::HTML(open(url).read)
end



def suggestions


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
      @items[1] = "750g"
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
        @items[1] = "750g"
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

           boucle = false if ((index_recipes >= nb_recipes) || (index_recipes > 1 ))
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
      @items[1] = "750g"
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

       boucle = false if ((index_recipes >= borne_index) || (index_recipes > 1 ))
      end #while boucle
    end # else  if (nb_recipes == 0)
   end #end  if @search_provider.include? "1"
  end # else  @search_recipe == "" || @search_provider.length == 0

end

  private

  def recipes_params
    params.require(:recipe).permit(:name, :photo)
  end

end











