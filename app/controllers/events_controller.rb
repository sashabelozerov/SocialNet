class EventsController < ApplicationController

	before_filter :require_user, :only => [:new, :create, :edit, :update]
	before_filter :current_user

  before_filter :get_user, :only => [:index, :show, :new, :edit]
  before_filter :get_event, :only => [:edit, :update, :destroy, :show]

  before_filter :account_sub_layout, :only => [:index, :show, :new, :edit]

  def index
     unauthorized! if cannot? :read, Event
    @events_as_author = @user.events_as_author
    @events_as_attendee = @user.events_as_attendee
  end
  
  def show
    unauthorized! if cannot? :read, Event
  end
  
  def new
    unauthorized! if cannot? :create, Event
    @event = @current_user.events_as_author.new
  end
  
  def create
    unauthorized! if cannot? :create, Event
    @event = @current_user.events_as_author.new(params[:event])
    if @event.save
      flash[:notice] = "Successfully created event."
      redirect_to user_event_url(@current_user, @event)
    else
      render :action => 'new'
    end
  end
  
  def edit
    unauthorized! if cannot? :update, @event
  end
  
  def update
    unauthorized! if cannot? :update, @event
    if @event.update_attributes(params[:event])
      flash[:notice] = "Successfully updated event."
      redirect_to user_event_url(@current_user, @event)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    unauthorized! if cannot? :destroy, @event
    @event.destroy
    flash[:notice] = "Successfully destroyed event."
    redirect_to @current_user
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_event
    @event = Event.find(params[:id])
  end

end
