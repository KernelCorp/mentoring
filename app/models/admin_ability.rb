class AdminAbility
  include CanCan::Ability

  def initialize(user)
    if user && user.has_role?(:admin)
      can :manage, :all
      can :access, :rails_admin
    end
  end
end
