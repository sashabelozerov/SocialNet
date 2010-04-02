class EventUsersController < ApplicationController
  
  def create
    unauthorized! if cannot? :create, EventUser
    @user = User.find(params[:user_id])
    @event = Event.find(params[:id])
    @target = User.find(params[:target_id])
    @target.invite(@event)
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

end
