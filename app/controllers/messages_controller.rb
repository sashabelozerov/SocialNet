class MessagesController < ApplicationController

  before_filter :require_user

  before_filter :get_message, :only => [:show, :destroy, :delete_from_mailbox]

  def delete_from_mailbox
    unauthorized! if cannot? :delete_from_mailbox, @message
    if @current_user.target?(@message)
      @message.update_attribute(:target_deleted, 1)
    else
      @message.update_attribute(:user_deleted, 1)
    end
    redirect_to user_url(@current_user)
  end

  def index
    unauthorized! if cannot? :read, Message
    @mailbox = params[:mailbox]
    @messages = @current_user.messages(@mailbox)
  end
  
  def show
    unauthorized! if cannot? :read, @message
    if @current_user.target?(@message)
      @message.update_attribute(:target_read, 1)
    else
      @message.update_attribute(:user_read, 1)
    end
  end
  
  def new
    unauthorized! if cannot? :create, Message
    @message = @current_user.messages_as_author.build
  end
  
  def create
    @message = @current_user.messages_as_author.build(params[:message])
    @message.target = User.find(params[:message][:target_id])
    @message.user = @current_user
    @message.user_read = 0;
    @message.target_read = 0;
    @message.user_deleted = 0;
    @message.target_deleted = 0;
    if @message.save
      flash[:notice] = "Successfully created message."
      redirect_to user_url(@current_user)
    else
      render :action => 'new'
    end
  end
  
  def destroy
    unauthorized! if cannot? :destroy, Message
    @message.destroy
    flash[:notice] = "Successfully destroyed message."
    redirect_to user_url(@current_user)
  end

  private

  def get_message
    @message = Message.find(params[:id])
  end

end
