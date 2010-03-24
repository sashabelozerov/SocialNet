class FriendshipsController < ApplicationController

	before_filter :current_user
	
  def create
    @friendship = @current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:notice] = "Added friend"
    else
      flash[:error] = "Unable to add a friend"
    end
    redirect_to users_url
  end
  
  def destroy
    @friendship = @current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to user_url(@current_user)
  end
end
