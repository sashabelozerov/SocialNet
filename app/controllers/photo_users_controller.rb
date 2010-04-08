class PhotoUsersController < ApplicationController
  def create
    unauthorized! if cannot? :create, PhotoUser
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @target = User.find(params[:target_id])
    @photo.tag(@target)
    redirect_to user_photo_url(@user, @photo)
  end
  
  def destroy
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @photo_user = @photo.photo_users.find_by_user_id(params[:target_id])
    unauthorized! if cannot? :destroy, @photo_user
    @photo_user.destroy
    redirect_to user_photo_url(@user, @photo)
  end

  def accept_tag
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
    @photo_user = @photo.photo_users.find_by_user_id(@user.id)
    @photo_user.accept_tag(@user)
    
    redirect_to user_photo_url(@user, @photo)
  end

end
