class PhotoUsersController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @target = User.find(params[:target_id])
    @target.sign(@photo)
    redirect_to user_photo_url(@user, @photo)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @photo_user = @photo.photo_users.find_by_user_id(params[:target_id])
    @photo_user.destroy
    redirect_to user_photo_url(@user, @photo)
  end
end
