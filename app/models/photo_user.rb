class PhotoUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :photo

  def accept_tag(photo_or_user)
    photo_or_user.photo_users.find(self.id).update_attribute(:accepted, 1)
  end

end
