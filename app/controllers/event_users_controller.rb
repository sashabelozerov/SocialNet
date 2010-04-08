class EventUsersController < ApplicationController
  
  def create
    unauthorized! if cannot? :create, EventUser
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @target = User.find(params[:target_id])
    @event.invite(@target)
    redirect_to user_event_url(@user, @event)
  end

  def destroy
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @event_user = @event.event_users.find_by_user_id(params[:target_id])
    unauthorized! if cannot? :destroy, @event_user
    @event_user.destroy
    redirect_to user_event_url(@user, @event)
  end

  def accept_invitation
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @event_user = @event.event_users.find_by_user_id(@user.id)
    @event_user.accept_invitation(@user)

    redirect_to user_event_url(@user, @event)
  end
end
