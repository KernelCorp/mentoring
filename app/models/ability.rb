class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can [:read, :create], Comment
      can :read, user

      if user.has_role? :admin
        can :manage, :all

      elsif user.has_role? :curator
        can :read, User, curator_id: user.id
        can :read, User.with_role(:curator)

        can :manage, Child, orphange_id: user.orphanage_id
        can [:read, :reject, :reject_report, :approve_report], Meeting, mentor: {curator_id: user.id}
        can [:read, :reject, :approve], Report, meeting: { mentor: {curator_id: user.id} }

        can :read, Book
        can :manage, Book, owner_id: user.id
        can :read, Album
        can :manage, Album, user_id: user.id
        can :read, Photo
        can :manage, Photo, user_id: user.id

      elsif user.has_role? :mentor
        can :read, User, id: user.curator_id
        can :read, Child, mentor_id: user.id
        can :manage, Meeting, mentor_id: user.id
        can [:read, :new, :create, :update, :resend], Report, meeting: {mentor_id: user.id}

        can :read, Book, owner_id: user.curator_id
        can :read, Album
        can :manage, Album, user_id: user.id
        can :read, Photo
        can :manage, Photo, user_id: user.id

      elsif user.has_role? :employee
        can :read, Album
        can :read, Photo
      end
    end
  end
end
