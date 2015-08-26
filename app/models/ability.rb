class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can [:read, :create], Comment

      if user.has_role? :admin
        can :manage, :all

      elsif user.has_role? :curator
        can :read, User, curator_id: user.id
        can :read, User.with_role(:curator)

        can :manage, Book
        can :manage, Child, orphange_id: user.orphanage_id
        can [:read, :reject, :reject_report, :approve_report], Meeting, mentor: {curator_id: user.id}
        can [:read, :reject, :approve], Report, meeting: { mentor: {curator_id: user.id} }

      elsif user.has_role? :mentor
        can :read, User, id: user.curator_id
        can :read, Book, owner_id: user.curator_id
        can :read, Child, mentor_id: user.id
        can :manage, Meeting, mentor_id: user.id
        can [:read, :new, :create, :update, :resend], Report, meeting: {mentor_id: user.id}
      end
    end
  end
end
