class FriendshipsController < ApplicationController

	before_filter :current_user
	
  def create
    @user = @current_user
    @friend = User.find(params[:friend_id])
    params[:friendship] = { :user_id => @user.id, :friend_id => @friend.id, :status => 'requested' }
    params[:inverse_friendship] = { :user_id => @friend.id, :friend_id => @user.id, :status => 'pending' }

    for friendship in @user.friendships
     if friendship.user_id==@user.id && friendship.friend_id==@friend.id
        flash[:error] = "Unable to add a friend"
        redirect_to root_url and return
     end
    end
    
    @friendship = Friendship.create(params[:friendship])
    @inverse_friendship = Friendship.create(params[:inverse_friendship])
    
    unauthorized! if (cannot? :create, @friendship) || (cannot? :create, @inverse_friendship)
    if @friendship.save && @inverse_friendship.save
      flash[:notice] = "Added friend"
    else
      flash[:error] = "Unable to add a friend"
    end
    redirect_to root_url
  end
  
  def destroy
    @user = @current_user
    @friend = User.find(params[:friend_id])
    @friendship = @user.friendships.find_by_friend_id(@friend.id)
    @inverse_friendship = @friend.friendships.find_by_friend_id(@user.id)
    #@friendship = @current_user.friendships.find(params[:id])
    unauthorized! if (cannot? :destroy, @friendship) || (cannot? :destroy, @inverse_friendship)
    @friendship.destroy
    @inverse_friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to user_url(@current_user)
  end

  def accept_friendship
    @user = @current_user
    @friendship = @user.friendships.find(params[:id])
    @inverse_friendship = Friendship.find_by_user_id_and_friend_id(@friendship.friend_id, @friendship.user_id)
    @friendship.update_attribute(:status, "accepted")
    @inverse_friendship.update_attribute(:status, "accepted")
    redirect_to user_url(@current_user)
  end

end
