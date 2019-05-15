class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Parking
    if user.present?
      can :create, Parking
      can [:update, :destroy], Parking do |parking|
        parking.user == user
      end
    end
  end
end
