class Message < ActiveRecord::Base
  attr_accessible :title, :content

	belongs_to :author, :class_name => "User", :foreign_key => "author_id"
	belongs_to :messageable, :polymorphic => true
end
