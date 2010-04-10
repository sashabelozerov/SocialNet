class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.require_password_confirmation = false
	end
	
	attr_accessible :name, :login, :password 

	has_many :messages_as_author, :class_name => "Message", :foreign_key => "user_id", :dependent => :destroy
	has_many :messages_as_recipient, :class_name => "Message", :foreign_key => "target_id", :dependent => :destroy

	has_many :friendships, :dependent => :destroy
  has_many :accepted_friendships, :class_name => "Friendship", :conditions => "status = 'accepted'", :dependent => :destroy
  has_many :requested_friendships, :class_name => "Friendship", :conditions => "status = 'requested'", :dependent => :destroy
  has_many :pending_friendships, :class_name => "Friendship", :conditions => "status = 'pending'", :dependent => :destroy
	
	has_many :events_as_author, :class_name => "Event", :foreign_key => "user_id", :dependent => :destroy
	has_many :event_users, :dependent => :destroy
	has_many :events_as_attendee, :source => :event, :through => :event_users

  has_many :photos_as_author, :class_name => "Photo", :foreign_key => "user_id", :dependent => :destroy
  has_many :photo_users, :dependent => :destroy
  has_many :photos_as_tagged, :source => :photo, :through => :photo_users
  
	has_many :comments, :dependent => :destroy

  def messages(mailbox)
    replies_as_author = Message.find_all_by_user_id(self.id, :conditions => "parent_id <> 0")
    replies_as_recipient = Message.find_all_by_target_id(self.id, :conditions => "parent_id <> 0")

    unless replies_as_author
       replies_as_author = []
    end
    unless replies_as_recipient
      replies_as_recipient = []
    end
    
    if mailbox == "sent"
      self.messages_as_author - replies_as_author
   	else
      self.messages_as_recipient - replies_as_recipient
   	end
  end

  def target?(message)
    message.target == self
  end

  def author?(stuff)
    stuff.user == self
  end

end
