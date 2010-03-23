class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start_time, :end_time, :user_id
  
  belongs_to :author, :class_name => "User", :foreign_key => "user_id" 
  #has_many :attendees, :through => :event_users
  
  has_many :comments, :as => :commentable
end
