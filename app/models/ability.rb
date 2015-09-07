class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.has_role? :employee
        common_access user

      elsif user.has_role? :mentor
        common_access user

        can :manage, Meeting, mentor_id: user.id
        can [:read, :new, :create, :update, :resend], Report, meeting: {mentor_id: user.id}

        can :read, Book, owner_id: user.curator_id
        can :manage, Album, user_id: user.id
        can :manage, Photo, user_id: user.id

        can :read, PublicActivity::Activity, {owner_type: 'User', owner_id: user.curator_id}

      elsif user.has_role? :curator
        common_access user

        can [:read, :reject, :reject_report, :approve_report], Meeting, mentor: {curator_id: user.id}
        can [:read, :reject, :approve], Report, meeting: { mentor: {curator_id: user.id} }

        can :read, Book
        can :manage, Book, owner_id: user.id
        can :manage, Album, user_id: user.id
        can :manage, Photo, user_id: user.id

        can :read, PublicActivity::Activity, {owner_type: 'User', owner_id: user.subordinates.with_role(:mentor).map(&:id)}

      elsif user.has_role? :admin
        can :manage, :all
      end
    end
  end

  private
    def common_access user
      can [:read, :create], Comment
      can :read, Album
      can :read, Photo
      can :read, User, orphanage_id: user.orphanage_id
      can :update, user
      can :read, Child, orphanage_id: user.orphanage_id
    end
end
