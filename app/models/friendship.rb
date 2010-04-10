class Friendship < ActiveRecord::Base
  attr_accessible :user_id, :friend_id, :status
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  #def accept_friendship(friendship)
  #end
end
