class MessagesController < ApplicationController

  before_filter :require_user

  before_filter :get_message, :only => [:show, :destroy]
  def index 
    @mailbox = params[:mailbox]
    @messages = @current_user.messages(@mailbox)
  end
  
  def show
  end
  
  def new
    @message = @current_user.messages_as_author.build
  end
  
  def create
	
    @message = @current_user.messages_as_author.build(params[:message])
    @message.user_target = User.find(params[:message][:user_id_target])
    @message.user = @current_user
    if @message.save
      flash[:notice] = "Successfully created message."
      redirect_to user_url(@current_user)
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @message.destroy
    flash[:notice] = "Successfully destroyed message."
    redirect_to user_url(@current_user)
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end

end
