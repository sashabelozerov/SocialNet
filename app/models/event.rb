class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start_time, :end_time, :user_id
  
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  has_many :events_users, :dependent => :destroy
  has_many :attendees, :through => :events_users
  
  has_many :comments, :as => :commentable, :dependent => :destroy
end
