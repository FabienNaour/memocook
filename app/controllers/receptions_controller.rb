class ReceptionsController < ApplicationController
  def new
    @reception = Reception.new
    @friends = Friend.where(user_id: current_user).all.order(:name)
    @recipes = Recipe.where(user_id: current_user).all.order(:name)
  end
  def create

    @friends_list = params[:reception][:friend_id]
    @friends_list.delete_if(&:blank?)
    @recipes_list = params[:reception][:recipe_id]
    @recipes_list.delete_if(&:blank?)
    @date= params[:reception][:date]


    if (@friends_list.length != 0 && @recipes_list.length != 0 && @date != "")

      @friends_list.each do |friend|
        @friend_invitation = Friend.find(friend)
        @recipes_list.each do |recipe|
          @recipe_invitation = Recipe.find(recipe)

          Reception.create(
              date: Date.parse(@date) ,
              friend: @friend_invitation,
              recipe: @recipe_invitation
            )
        end
      end
      redirect_to friends_path
    else
      @reception = Reception.new
      render :new
    end

  end
  private

  def receptions_params
    params.require(:reception).permit(:date,:friend_id)
  end
end
