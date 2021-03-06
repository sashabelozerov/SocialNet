class UsersController < ApplicationController

  before_filter :require_user, :only => :show
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :current_user, :only => [:index, :destroy, :edit, :update]


  def index
    unauthorized! if cannot? :show, User
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unauthorized! if cannot? :show, @user
  end

  def new
    unauthorized! if cannot? :create, User
    @user = User.new
  end

  def create
    unauthorized! if cannot? :create, User
  	@user = User.new(params[:user])
    if @user.save
     	flash[:notice] = "Account registered successful"
     	redirect_to users_url
  	else
    	render :action => "new"
  	end
  end

  def edit
    unauthorized! if cannot? :update, @current_user
  end
  
  def update
    @user = User.find(params[:id])
    unauthorized! if cannot? :update, @user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Successfully updated profile.'
      redirect_to @current_user
    else
      render :action => "edit"
    end
  end
  
  def destroy
    unauthorized! if cannot? :destroy, @current_user
    @current_user.destroy
    redirect_to users_url
  end

end
