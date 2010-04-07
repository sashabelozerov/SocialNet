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
	has_many :event_users, :dependent => :destroy
	has_many :events_as_attendee, :source => :event, :through => :event_users

  has_many :photos_as_author, :class_name => "Photo", :foreign_key => "user_id", :dependent => :destroy
  has_many :photo_users, :dependent => :destroy
  has_many :photos_as_signed, :source => :photo, :through => :photo_users
  
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

  def author?(stuff)
    stuff.user == self
  end

  def invite(event)
    unless event.event_users.find_by_user_id(self.id)
      @eu = event.event_users.build(:user_id => self.id)
      @eu.save
    end
  end

  def sign(photo)
    unless photo.photo_users.find_by_user_id(self.id)
      @pu = photo.photo_users.build(:user_id => self.id)
      @pu.save
    end
  end

end
