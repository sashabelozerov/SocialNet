class Photo < ActiveRecord::Base
  #attr_accessible :title
  has_attached_file :image, :styles => { :small => "100x100>", :large => "640x480>" }

  #validates_attachment_presence :image
  #validates_attachment_size :image, :less_than => 3.megabytes
  #validates_attachment_content_type :image, :content_type => ['image/jpg', 'image/jpeg', 'image/png', 'image/bmp']
  
  belongs_to :user
  has_many :photo_users, :dependent => :destroy
  has_many :tagged_users, :source => :user, :through => :photo_users

  has_many :comments, :as => :commentable, :dependent => :destroy



  def tag(user)
    unless user.photo_users.find_by_photo_id(self.id)
      @pu = user.photo_users.build(:photo_id => self.id, :accepted => 0)
      @pu.save
    end
  end

end
