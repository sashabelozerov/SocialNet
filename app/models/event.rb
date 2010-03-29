class Event < ActiveRecord::Base
  attr_accessible :title, :description, :start_time, :end_time, :user_id
  
  belongs_to :user
  has_many :event_users, :dependent => :destroy
  has_many :attendees, :source => :user, :through => :event_users
  
  has_many :comments, :as => :commentable, :dependent => :destroy

end
