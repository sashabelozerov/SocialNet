class CommentsController < ApplicationController

  before_filter :find_commentable
  before_filter :current_user, :only => [:index, :show, :new, :create, :edit, :destroy]

  def index
  	@commentable = find_commentable
    @comments = @commentable.comments.all
  end
  
  def show
  	@commentable = find_commentable
    @comment = @commentable.comments.find(params[:id])
  end
  
  def new
    @comment = @commentable.comments.new
     unauthorized! if cannot? :create, @comment
  end
  
  def create
    @comment = @commentable.comments.build(params[:comment])
    unauthorized! if cannot? :create, @comment
    if @comment.save
      flash[:notice] = "Successfully created comment."
      redirect_to user_url(@current_user)
      #redirect_to :id => nil
    else
      render :action => 'new'
    end
  end
  
  def edit
    @comment = @commentable.comments.find(params[:id])
    unauthorized! if cannot? :update, @comment
  end
  
  def update
    @comment = @commentable.comments.find(params[:id])
    unauthorized! if cannot? :update, @comment
    if @comment.update_attributes(params[:comment])
      flash[:notice] = "Successfully updated comment."
      redirect_to user_url(@current_user)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @comment = @commentable.comments.find(params[:id])
    unauthorized! if cannot? :destroy, @comment
    @comment.destroy
    flash[:notice] = "Successfully destroyed comment."
    redirect_to user_url(@current_user)
  end

  private

  def find_commentable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        @commentable = $1.classify.constantize.find(value)
        break
      end
    end
    @commentable
  end


end
