class Message < ActiveRecord::Base
	attr_accessible :title, :content
	validates_presence_of :user_id_target
	
	belongs_to :user
	belongs_to :user_target, :class_name => "User", :foreign_key => "user_id_target"
end
