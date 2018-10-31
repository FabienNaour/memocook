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


def open_file(url)
  return Nokogiri::HTML(open(url).read)
end



def suggestions


  # DEBUT MARMITON
  require 'open-uri'
  @search_recipe = params[:recipe][:name]
  @search_provider = params[:items]
  @search_provider.delete_if(&:blank?)


  if @search_recipe == "" || @search_provider.length == 0
    @recipe = Recipe.new
    @items = []
    @items[0] = "Marmiton"
    @items[1] = "750g"
    render :new
  else
    #DEBUT MARMITON
    if @search_provider.include? "0"

      url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@search_recipe}"
      html_doc = open_file(url)

      # on recupere le Nb de recettes à parser
      nb_recipes = 0

      if (html_doc.search('.recipe-search__nb-results')[0] == nil)
        @recipe = Recipe.new

        render :new
      else

          nb_recipes = html_doc.search('.recipe-search__nb-results')[0].text.split[0].to_i

           # boucle sur chaque page
           boucle = true
           index_recipes = 0
           @suggestions = []
           while (boucle)

            url = "https://www.marmiton.org/recettes/recherche.aspx?type=all&aqt=#{@search_recipe}"+"&start=#{index_recipes}"
            html_doc = open_file(url)

            html_doc.search('.recipe-card-link').each do |element|
              # on ne selectinne que les fiches (donc recettes) qui sont notées
              if (element.search('.recipe-card__rating')[0] != nil)
                @suggestions << {
                link: element.attribute('href').value,
                name: element.search('.recipe-card__title')[0].text.strip,
                picture: element.search('.recipe-card__picture img').attribute('src').value,
                logo: "M"

                }
              end
           end
           index_recipes += 12

           boucle = false if ((index_recipes >= nb_recipes) || (index_recipes > 1 ))

          end
      end #else if (html_doc.search('.recipe-search__nb-results')[0] == nil)
      # FIN MARMITON
    end #if @search_provider.include? "0"
  #DEBUT 750gr
  if @search_provider.include? "1"
    url = "https://www.750g.com/recherche.htm?search=#{@search_recipe}"
    html_doc = open_file(url)
    # on recupere le Nb de recettes à parser
    nb_recipes = 0


# <section class="c-row c-recipe-row has-link-wrapper u-margin-vert u-border recipe-9122">
#     <div class="c-row__media c-recipe-row__media">
#                                             <img class="lazyed" src="https://static.750g.com/images/200-160/default/img-default.jpg" width="200" height="160">
#                                     </div>
#     <div class="c-row__body">
#                 <h2 class="c-row__title c-recipe-row__title"><a class="u-link-wrapper" href="/tagine-aux-olives-r9122.htm" target="_self">Tagine aux olives</a></h2>
#                     <p class="c-row__desc">faire revenir les petits oignons dans du beurre, faire griller la viande (agneau ou poulet) . Ajouter les olives et 50 cl d'eau. Faire cuire à feu doux 1h. C'est bon</p>

#                 <div class="c-recipe-row__rating c-recipe-row__rating--marge">


# <div class="c-rating">
# <span class="c-rating__note"><svg aria-labelledby="title" role="img" class="u-icon u-icon-star-12" viewBox="0 0 18 18" width="18" height="18"><title lang="fr">Icone étoile</title><path d="M17.7,6.8c-0.2-0.2-0.6-0.2-1.1-0.2c-1.3,0-3,0.1-4.6,0.1c-0.3-0.8-0.6-1.7-0.8-2.2c-0.3-0.6-0.6-1.2-0.8-1.9l0-0.1c-0.4-1-0.8-2.2-1.4-2.3l0,0c-0.1,0-0.2,0.1-0.2,0.2c0,0,0,0,0,0.1C8.5,0.7,8.3,1,8.2,1.4C7.6,2.9,6.9,5,6.3,6.7c-1.5,0-3.2,0-4.5,0C1.2,6.7,0.7,6.8,0.4,7c0,0,0,0,0,0l0,0c0,0,0,0,0,0c-0.1,0-0.1,0.1-0.1,0.1l0,0c0,0.1,0,0.2,0.1,0.3c0,0,0.1,0.1,0.2,0.1C0.6,7.8,0.8,8,1.1,8.2c1,0.7,2.4,1.5,3.6,2.4c-0.7,1.7-1.5,3.8-2.1,5.2c-0.2,0.6-0.3,1.1-0.2,1.5c0,0.1,0,0.1,0,0.2c0,0,0,0.1,0,0.1l0,0c0.1,0.1,0.2,0.1,0.3,0c0,0,0,0,0.1,0c0.4-0.1,0.9-0.3,1.3-0.6c1.4-1,3.3-2.4,4.8-3.5c1.5,1.1,3.5,2.5,4.9,3.4c0.5,0.3,1,0.6,1.4,0.6c0,0,0,0,0.1,0l0,0c0.1,0,0.1,0,0.1,0c0,0,0,0,0,0l0,0c0.1-0.1,0.1-0.2,0.1-0.3c0,0,0,0,0-0.1c0-0.4-0.3-1.2-0.6-1.9l0-0.1c-0.3-0.7-0.6-1.5-0.9-2.3c-0.3-0.7-0.6-1.5-0.9-2.3c1.2-0.9,2.6-1.7,3.6-2.4c0.4-0.3,0.7-0.6,0.8-0.8c0.1,0,0.1-0.1,0.2-0.2l0,0C17.8,6.9,17.8,6.8,17.7,6.8z"></path></svg></span><span class="c-rating__note"><svg aria-labelledby="title" role="img" class="u-icon u-icon-star-12" viewBox="0 0 18 18" width="18" height="18"><title lang="fr">Icone étoile</title><path d="M17.7,6.8c-0.2-0.2-0.6-0.2-1.1-0.2c-1.3,0-3,0.1-4.6,0.1c-0.3-0.8-0.6-1.7-0.8-2.2c-0.3-0.6-0.6-1.2-0.8-1.9l0-0.1c-0.4-1-0.8-2.2-1.4-2.3l0,0c-0.1,0-0.2,0.1-0.2,0.2c0,0,0,0,0,0.1C8.5,0.7,8.3,1,8.2,1.4C7.6,2.9,6.9,5,6.3,6.7c-1.5,0-3.2,0-4.5,0C1.2,6.7,0.7,6.8,0.4,7c0,0,0,0,0,0l0,0c0,0,0,0,0,0c-0.1,0-0.1,0.1-0.1,0.1l0,0c0,0.1,0,0.2,0.1,0.3c0,0,0.1,0.1,0.2,0.1C0.6,7.8,0.8,8,1.1,8.2c1,0.7,2.4,1.5,3.6,2.4c-0.7,1.7-1.5,3.8-2.1,5.2c-0.2,0.6-0.3,1.1-0.2,1.5c0,0.1,0,0.1,0,0.2c0,0,0,0.1,0,0.1l0,0c0.1,0.1,0.2,0.1,0.3,0c0,0,0,0,0.1,0c0.4-0.1,0.9-0.3,1.3-0.6c1.4-1,3.3-2.4,4.8-3.5c1.5,1.1,3.5,2.5,4.9,3.4c0.5,0.3,1,0.6,1.4,0.6c0,0,0,0,0.1,0l0,0c0.1,0,0.1,0,0.1,0c0,0,0,0,0,0l0,0c0.1-0.1,0.1-0.2,0.1-0.3c0,0,0,0,0-0.1c0-0.4-0.3-1.2-0.6-1.9l0-0.1c-0.3-0.7-0.6-1.5-0.9-2.3c-0.3-0.7-0.6-1.5-0.9-2.3c1.2-0.9,2.6-1.7,3.6-2.4c0.4-0.3,0.7-0.6,0.8-0.8c0.1,0,0.1-0.1,0.2-0.2l0,0C17.8,6.9,17.8,6.8,17.7,6.8z"></path></svg></span><span class="c-rating__note"><svg aria-labelledby="title" role="img" class="u-icon u-icon-star-12" viewBox="0 0 18 18" width="18" height="18"><title lang="fr">Icone étoile</title><path d="M17.7,6.8c-0.2-0.2-0.6-0.2-1.1-0.2c-1.3,0-3,0.1-4.6,0.1c-0.3-0.8-0.6-1.7-0.8-2.2c-0.3-0.6-0.6-1.2-0.8-1.9l0-0.1c-0.4-1-0.8-2.2-1.4-2.3l0,0c-0.1,0-0.2,0.1-0.2,0.2c0,0,0,0,0,0.1C8.5,0.7,8.3,1,8.2,1.4C7.6,2.9,6.9,5,6.3,6.7c-1.5,0-3.2,0-4.5,0C1.2,6.7,0.7,6.8,0.4,7c0,0,0,0,0,0l0,0c0,0,0,0,0,0c-0.1,0-0.1,0.1-0.1,0.1l0,0c0,0.1,0,0.2,0.1,0.3c0,0,0.1,0.1,0.2,0.1C0.6,7.8,0.8,8,1.1,8.2c1,0.7,2.4,1.5,3.6,2.4c-0.7,1.7-1.5,3.8-2.1,5.2c-0.2,0.6-0.3,1.1-0.2,1.5c0,0.1,0,0.1,0,0.2c0,0,0,0.1,0,0.1l0,0c0.1,0.1,0.2,0.1,0.3,0c0,0,0,0,0.1,0c0.4-0.1,0.9-0.3,1.3-0.6c1.4-1,3.3-2.4,4.8-3.5c1.5,1.1,3.5,2.5,4.9,3.4c0.5,0.3,1,0.6,1.4,0.6c0,0,0,0,0.1,0l0,0c0.1,0,0.1,0,0.1,0c0,0,0,0,0,0l0,0c0.1-0.1,0.1-0.2,0.1-0.3c0,0,0,0,0-0.1c0-0.4-0.3-1.2-0.6-1.9l0-0.1c-0.3-0.7-0.6-1.5-0.9-2.3c-0.3-0.7-0.6-1.5-0.9-2.3c1.2-0.9,2.6-1.7,3.6-2.4c0.4-0.3,0.7-0.6,0.8-0.8c0.1,0,0.1-0.1,0.2-0.2l0,0C17.8,6.9,17.8,6.8,17.7,6.8z"></path></svg></span><span class="c-rating__note"><svg aria-labelledby="title" role="img" class="u-icon u-icon-star-12" viewBox="0 0 18 18" width="18" height="18"><title lang="fr">Icone étoile</title><path d="M17.7,6.8c-0.2-0.2-0.6-0.2-1.1-0.2c-1.3,0-3,0.1-4.6,0.1c-0.3-0.8-0.6-1.7-0.8-2.2c-0.3-0.6-0.6-1.2-0.8-1.9l0-0.1c-0.4-1-0.8-2.2-1.4-2.3l0,0c-0.1,0-0.2,0.1-0.2,0.2c0,0,0,0,0,0.1C8.5,0.7,8.3,1,8.2,1.4C7.6,2.9,6.9,5,6.3,6.7c-1.5,0-3.2,0-4.5,0C1.2,6.7,0.7,6.8,0.4,7c0,0,0,0,0,0l0,0c0,0,0,0,0,0c-0.1,0-0.1,0.1-0.1,0.1l0,0c0,0.1,0,0.2,0.1,0.3c0,0,0.1,0.1,0.2,0.1C0.6,7.8,0.8,8,1.1,8.2c1,0.7,2.4,1.5,3.6,2.4c-0.7,1.7-1.5,3.8-2.1,5.2c-0.2,0.6-0.3,1.1-0.2,1.5c0,0.1,0,0.1,0,0.2c0,0,0,0.1,0,0.1l0,0c0.1,0.1,0.2,0.1,0.3,0c0,0,0,0,0.1,0c0.4-0.1,0.9-0.3,1.3-0.6c1.4-1,3.3-2.4,4.8-3.5c1.5,1.1,3.5,2.5,4.9,3.4c0.5,0.3,1,0.6,1.4,0.6c0,0,0,0,0.1,0l0,0c0.1,0,0.1,0,0.1,0c0,0,0,0,0,0l0,0c0.1-0.1,0.1-0.2,0.1-0.3c0,0,0,0,0-0.1c0-0.4-0.3-1.2-0.6-1.9l0-0.1c-0.3-0.7-0.6-1.5-0.9-2.3c-0.3-0.7-0.6-1.5-0.9-2.3c1.2-0.9,2.6-1.7,3.6-2.4c0.4-0.3,0.7-0.6,0.8-0.8c0.1,0,0.1-0.1,0.2-0.2l0,0C17.8,6.9,17.8,6.8,17.7,6.8z"></path></svg></span><span class="c-rating__note"><svg aria-labelledby="title" role="img" class="u-icon u-icon-star-12" viewBox="0 0 18 18" width="18" height="18"><title lang="fr">Icone étoile</title><path d="M17.7,6.8c-0.2-0.2-0.6-0.2-1.1-0.2c-1.3,0-3,0.1-4.6,0.1c-0.3-0.8-0.6-1.7-0.8-2.2c-0.3-0.6-0.6-1.2-0.8-1.9l0-0.1c-0.4-1-0.8-2.2-1.4-2.3l0,0c-0.1,0-0.2,0.1-0.2,0.2c0,0,0,0,0,0.1C8.5,0.7,8.3,1,8.2,1.4C7.6,2.9,6.9,5,6.3,6.7c-1.5,0-3.2,0-4.5,0C1.2,6.7,0.7,6.8,0.4,7c0,0,0,0,0,0l0,0c0,0,0,0,0,0c-0.1,0-0.1,0.1-0.1,0.1l0,0c0,0.1,0,0.2,0.1,0.3c0,0,0.1,0.1,0.2,0.1C0.6,7.8,0.8,8,1.1,8.2c1,0.7,2.4,1.5,3.6,2.4c-0.7,1.7-1.5,3.8-2.1,5.2c-0.2,0.6-0.3,1.1-0.2,1.5c0,0.1,0,0.1,0,0.2c0,0,0,0.1,0,0.1l0,0c0.1,0.1,0.2,0.1,0.3,0c0,0,0,0,0.1,0c0.4-0.1,0.9-0.3,1.3-0.6c1.4-1,3.3-2.4,4.8-3.5c1.5,1.1,3.5,2.5,4.9,3.4c0.5,0.3,1,0.6,1.4,0.6c0,0,0,0,0.1,0l0,0c0.1,0,0.1,0,0.1,0c0,0,0,0,0,0l0,0c0.1-0.1,0.1-0.2,0.1-0.3c0,0,0,0,0-0.1c0-0.4-0.3-1.2-0.6-1.9l0-0.1c-0.3-0.7-0.6-1.5-0.9-2.3c-0.3-0.7-0.6-1.5-0.9-2.3c1.2-0.9,2.6-1.7,3.6-2.4c0.4-0.3,0.7-0.6,0.8-0.8c0.1,0,0.1-0.1,0.2-0.2l0,0C17.8,6.9,17.8,6.8,17.7,6.8z"></path></svg></span>            <span class="c-rating__votes"><span>1</span> vote</span>
#     </div>
#         </div>
#                                     </div>


# </section>











  end #end  if @search_provider.include? "1"
  end # else  @search_recipe == "" || @search_provider.length == 0

end

  private

  def recipes_params
    params.require(:recipe).permit(:name)
  end

end
