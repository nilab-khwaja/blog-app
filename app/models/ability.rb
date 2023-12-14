# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.role = 'admin'
      can :manage, :all
    else
      can :read, :all
      can :manage, Post, author_id: user_id
      can :manage, Comment, user_id:
    end
  end
end
