class EventUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  def accept_invitation(event_or_user)
    event_or_user.event_users.find(self.id).update_attribute(:accepted, 1)
  end

end
