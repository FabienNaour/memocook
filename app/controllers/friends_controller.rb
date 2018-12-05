class FriendsController < ApplicationController
  def show
    @friend = Friend.find(params[:id])
    @receptions = Reception.where(friend_id: @friend).all.order(:date).reverse
  end

  def index
    @friends = Friend.where(user_id: current_user).all.order(:name)
    @recipes = Recipe.where(user_id: current_user).all.order(:name)
  end

  def load_avatar
     avatars = []
     i = 0
     while i < 21
      avatars[i] = "icons/AV#{i}.png"
      i += 1
     end
    return avatars
  end

  def new
    @friend = Friend.new
    @items = []
    @items = load_avatar

  end


  def create

    @friend = Friend.new(friends_params)

    @friend_name = params[:friend][:name]


    # si nom saisi vide Pb
    if @friend_name == ""
        @friend = Friend.new
        @items = []
        @items = load_avatar
        render :new
   else
        @friend.user = current_user
        @avatar = params[:items]
        @avatar.delete_if(&:blank?)
        # si pas d'avatar saisi on affecte le premier
        if @avatar.length == 0
          @friend.avatar = "icons/AV0.png"
        else
          index = @avatar[0].to_i
          @friend.avatar =  "icons/AV#{index}.png"
        end

        if @friend.save
          redirect_to friends_path
        else
          render :new
        end
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



