class User < ActiveRecord::Base
	acts_as_authentic do |c|
		c.require_password_confirmation = false
	end

	has_many :messages_as_author, :class_name => "Message", :foreign_key => "user_id"
	has_many :messages_as_recipient, :class_name => "Message", :foreign_key => "user_id_target"

	has_many :friendships, :dependent => :destroy
	has_many :friends, :through => :friendships
end
