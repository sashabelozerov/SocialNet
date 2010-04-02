class Message < ActiveRecord::Base
	attr_accessible :title, :content
	validates_presence_of :target_id

  acts_as_tree :order => "created_at"

	belongs_to :user
	belongs_to :target, :class_name => "User", :foreign_key => "target_id"

  def self.new_reply(sender, in_reply_to = nil, params = {})

    if in_reply_to
      return nil if in_reply_to.target != sender #can only reply to messages you received
      message = in_reply_to.children.build(params[:message])
      message.target = User.find(in_reply_to.user_id)
      message.user = sender
      message.title = ''
      in_reply_to.update_attribute(:user_id, sender.id)
      in_reply_to.update_attribute(:target_id, message.target_id)
      in_reply_to.update_attribute(:target_read, 0) if in_reply_to.target_read == 1
      in_reply_to.update_attribute(:target_deleted, 0) if in_reply_to.target_deleted == 1
      in_reply_to.update_attribute(:user_deleted, 0) if in_reply_to.user_deleted == 1
      
    else
      return nil if params[:message][:target_id] == params[:user_id]
      message = sender.messages_as_author.build(params[:message])
      message.target = User.find(params[:message][:target_id])
      message.user = sender
    end

    message.user_read = 1;
    message.target_read = 0;
    message.user_deleted = 0;
    message.target_deleted = 0;

    message
  end

end
