class Ability
  include CanCan::Ability

  def initialize(user)

    can [:read, :create], User
    can [:update, :destroy], User do |u|
      u && u == user
    end

    can [:read, :create], Event
    can [:update, :destroy], Event do |event|
      event && event.user == user
    end

    can :create, EventUser
    can :destroy, EventUser do |event_user|
        event_user && ((event_user.user == user) || (event_user.event.user == user))
    end

    can [:read, :create], Photo
    can [:update, :destroy], Photo do |photo|
      photo && photo.user == user
    end

    can :create, PhotoUser
    can :destroy, PhotoUser do |photo_user|
      photo_user && ((photo_user.user == user) || (photo_user.photo.user == user))
    end

    can [:read, :create], Comment
    can :destroy, Comment do |comment|
      comment && (comment.user == user || comment.commentable.user == user)
    end

    can [:read, :create], Message
    can :delete_from_mailbox, Message do |message|
      message && ( message.user == user || message.target == user )
    end

    can :create, Friendship
    can :destroy, Friendship do |friendship|
      friendship && friendship.user == user
    end

  end
end