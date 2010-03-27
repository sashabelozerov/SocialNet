class Ability
  include CanCan::Ability

  def initialize(user)

    can [:read, :create], User
    can [:update, :destroy], User do |u|
      u && u == user
    end

    can [:read, :create], Event
    can [:update, :destroy], Event do |event|
      event && event.author == user
    end

    can [:read, :create], Comment
    can :destroy, Comment do |comment|
      comment && comment.user == user
    end

    can [:read, :create], Message
    can :delete_from_mailbox, Message do |message|
      message && ( message.user == user || message.target == user )
    end

    can [:create, :destroy], Friendship do |friendship|
      friendship && friendship.user == user
    end

  end
end