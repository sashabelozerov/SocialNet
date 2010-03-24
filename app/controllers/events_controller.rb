class EventsController < ApplicationController

	before_filter :require_user, :only => [:new, :create, :edit, :update]
	before_filter :current_user
	
  def index
	@user = User.find(params[:user_id])
    @events = @user.events_as_author.all
  end
  
  def show
	@user = User.find(params[:user_id])
    @event = @user.events_as_author.find(params[:id])
  end
  
  def new
    @event = @current_user.events_as_author.new
  end
  
  def create
    @event = @current_user.events_as_author.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to user_event_url(@current_user, @event)
    else
      render :action => 'new'
    end
  end
  
  def edit
    @event = @current_user.events_as_author.find(params[:id])
  end
  
  def update
    @event = @current_user.events_as_author.find(params[:id])
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to user_event_url(@current_user, @event)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @event = @current_user.events_as_author.find(params[:id])
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to @current_user
  end
end
