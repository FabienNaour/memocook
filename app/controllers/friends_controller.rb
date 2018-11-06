class FriendsController < ApplicationController
  def show
    @friend = Friend.find(params[:id])
    @receptions = Reception.where(friend_id: @friend).all.order(:date)
  end

  def index
    @friends = Friend.where(user_id: current_user).all.order(:name)
    @recipes = Recipe.where(user_id: current_user).all.order(:name)
  end

  def new
    @friend = Friend.new


  end

  def create
    @friend = Friend.new(friends_params)
    @friend.user = current_user

    if @friend.save
      redirect_to friends_path
    else
      render :new
    end
  end

  def destroy
    @friend = Friend.find(params[:id])
    @friend.destroy
    redirect_to friends_path
  end

  private

  def friends_params
    # params.require(:friend).permit(:name, :email, :telephone)
    params.require(:friend).permit(:name)

  end

end



