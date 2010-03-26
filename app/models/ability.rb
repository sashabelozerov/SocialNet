class Ability
  include CanCan::Ability

  def initialize(user)

    can :read, User
    can [:update, :destroy], User do |u|
      u == user
    end

    can [:read, :create], Event
    can [:update, :destroy], Event do |event|
      event && event.author == user
    end

    can [:read, :create], Comment
    can :destroy, Comment do |comment|
      comment && comment.user == user
    end

    can :create, Message
    can [:read, :delete_from_mailbox], Message do |message|
      message && (Message.user == user || Message.target == user)
    end

  end
end