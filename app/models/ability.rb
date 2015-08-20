class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all

    elsif user.has_role? :curator
      can :manage, Child, orphange_id: user.orphanage_id
      can [:read, :reject], Meeting, mentor: {curator_id: user.id}
      can [:read, :reject, :verify], Report, meeting: { mentor: {curator_id: user.id} }

    elsif user.has_role? :mentor
      can :read, Child, mentor_id: user.id
      can :manage, Meeting, mentor_id: user.id
      can :manage, Report, meeting: {mentor_id: user.id}

    end
  end
end
