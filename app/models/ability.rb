class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all

    elsif user.has_role? :curator
      can :manage, Meeting, mentor: {curator_id: user.id}

    elsif user.has_role? :mentor
      can :manage, Meeting, mentor_id: user.id

    end
  end
end
