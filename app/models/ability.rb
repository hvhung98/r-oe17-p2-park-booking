class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Parking
    can :create, Order
    if user.present?
      can :create, Parking
      can [:update, :destroy], Parking do |parking|
        parking.user == user
      end
      can :read, Order do |order|
        order.user == user || order.user.role_id == 2 ||
        order.orderable_id == user.parking.id
      end
      can :update, Order do |order|
        order.user == user
      end
    end
  end
end
