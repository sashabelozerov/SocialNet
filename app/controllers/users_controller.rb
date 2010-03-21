class UsersController < ApplicationController

  before_filter :require_user, :only => :show
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :current_user, :only => [:index, :destroy]

  def index
	@users = User.all
  end

  def show
	@user = User.find(params[:id])
  end

  def new
	@user = User.new
  end

  def create
	@user = User.new(params[:user])
	if @user.save
		flash[:notice] = "Account registered successful"
		redirect_to users_url
	else
		render :action => "new"
	end
  end

  def destroy
    @current_user.destroy
    redirect_to users_url
  end

end
