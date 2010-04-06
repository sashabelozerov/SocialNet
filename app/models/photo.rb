class Photo < ActiveRecord::Base
  #attr_accessible :title
  has_attached_file :image, :styles => { :small => "100x100>" }

  #validates_attachment_presence :image
  #validates_attachment_size :image, :less_than => 3.megabytes
  #validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/bmp']
  
  belongs_to :user
  has_many :photo_users, :dependent => :destroy
  has_many :signed_users, :source => :user, :through => :photo_users

  has_many :comments, :as => :commentable, :dependent => :destroy
  
end
