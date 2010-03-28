class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.require_password_confirmation = false
	end
	
	attr_accessible :name, :login, :password 

	has_many :messages_as_author, :class_name => "Message", :foreign_key => "user_id", :dependent => :destroy
	has_many :messages_as_recipient, :class_name => "Message", :foreign_key => "target_id", :dependent => :destroy

	has_many :friendships, :dependent => :destroy
	has_many :friends, :through => :friendships
	
	has_many :events_as_author, :class_name => "Event", :foreign_key => "user_id", :dependent => :destroy
	has_many :event_users
	has_many :events_as_attendee, :source => "Event", :through => :event_users
	
	has_many :comments, :dependent => :destroy

  def messages(mailbox)
    replies = Message.all(:conditions => "parent_id <> 0")
    
    if mailbox == "sent"
      self.messages_as_author - replies
   	else
      self.messages_as_recipient - replies
   	end
  end

  def target?(message)
    message.target == self
  end

  def author?(message)
    message.user == self
  end
  
end
