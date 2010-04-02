class Photo < ActiveRecord::Base
  attr_accessible :title

  belongs_to :user
  has_many :photo_users, :dependent => :destroy
  has_many :signed_users, :source => :user, :through => :photo_users

  has_many :comments, :as => :commentable, :dependent => :destroy
  
end
