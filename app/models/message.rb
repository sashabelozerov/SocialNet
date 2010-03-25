class Message < ActiveRecord::Base
	attr_accessible :title, :content
	validates_presence_of :target_id
	
	belongs_to :user
	belongs_to :target, :class_name => "User", :foreign_key => "target_id"
end
