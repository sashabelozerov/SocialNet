class MessagesController < ApplicationController

  before_filter :require_user

  def index 
	@mailbox = params[:mailbox]
	if @mailbox == "sent"
     		 @messages = @current_user.messages_as_author.find(:all)
   	else
      	 @messages = @current_user.messages_as_recipient.find(:all)
   	end
  end
  
  def show
    @message = Message.find(params[:id])
  end
  
  def new
      @message = @current_user.messages_as_author.build
  end
  
  def create
	
     @message = @current_user.messages_as_author.build(params[:message])
     if @message.save
     	 flash[:notice] = "Successfully created message."
   	 redirect_to user_url(@current_user)
     else
       render :action => 'new'
    end
  end
  
  def destroy
    #@message = Message.find(params[:id])
    # @message.destroy
    # flash[:notice] = "Successfully destroyed message."
    redirect_to messages_url
  end
end
