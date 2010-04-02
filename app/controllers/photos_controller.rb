class PhotosController < ApplicationController

  before_filter :require_user, :only => [:new, :create, :edit, :update]
	before_filter :current_user

  before_filter :get_user, :only => [:index, :show]
  before_filter :get_photo, :only => [:edit, :update, :destroy, :show]

  def show
  end

  def new
    @photo = @current_user.photos_as_author.new
  end
  
  def create
   @photo = @current_user.photos_as_author.new(params[:photo])
    if @photo.save
      flash[:notice] = "Successfully created photo."
      redirect_to user_photo_url(@current_user, @photo)
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @photo.update_attributes(params[:photo])
      flash[:notice] = "Successfully updated photo."
      redirect_to user_photo_url(@current_user, @photo)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @photo.destroy
    flash[:notice] = "Successfully destroyed photo."
    redirect_to root_url
  end


  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_photo
    @photo = Photo.find(params[:id])
  end

end
