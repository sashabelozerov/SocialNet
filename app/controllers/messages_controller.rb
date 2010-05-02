class MessagesController < ApplicationController

  before_filter :require_user

  before_filter :get_message, :only => [:show, :destroy, :delete_from_mailbox]
  before_filter :account_sub_layout, :only => [:index, :show, :new]

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
    @user = @current_user;
    unauthorized! if cannot? :read, Message
    @mailbox = params[:mailbox]
    @messages = @current_user.messages(@mailbox)
  end
  
  def show
    @user = current_user;
    unauthorized! if cannot? :read, @message
    if @current_user.target?(@message) && @message.target_read == 0
      @message.update_attribute(:target_read, 1)
    else
      if @current_user.author?(@message) && @message.user_read == 0
        @message.update_attribute(:user_read, 1)
      end
    end
  end
  
  def new
    @user = @current_user;
    if params[:reply_to]
      @in_reply_to = Message.find(params[:reply_to])
    end
    if @in_reply_to
      @message = @in_reply_to.children.build
      session[:reply_to] = @in_reply_to.id
    else
      @message = @current_user.messages_as_author.build
    end
  end
  
  def create
    if session[:reply_to]
      in_reply_to = Message.find(session[:reply_to])
      session[:reply_to] = nil
    end
    @message = Message.new_reply(@current_user, in_reply_to, params)
    #redirect_to users_url and return if @message == nil
    if @message && @message.save
      flash[:notice] = "Successfully created message."
      redirect_to user_url(@current_user)
    else
      flash[:error] = "Message was NOT created."
      redirect_to user_url(@current_user)
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
