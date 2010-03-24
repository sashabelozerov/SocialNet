class EventsController < ApplicationController

	before_filter :require_user, :only => [:new, :create, :edit, :update]
	before_filter :current_user

  before_filter :get_user, :only => [:index, :show]
  before_filter :get_event, :only => [:edit, :update, :destroy]
	
  def index
    @events = @user.events_as_author
  end
  
  def show
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
  end
  
  def update
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to user_event_url(@current_user, @event)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to @current_user
  end

  private
  def get_user
    @user = User.find(params[:user_id])
  end

  def get_event

  end
end
