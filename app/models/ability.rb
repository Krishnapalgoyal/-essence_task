class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    case user.role
    when 'admin'
      can :manage, :all

    when 'service_provider'
      can :manage, Service, user_id: user.id
      can :manage, ServiceAvailableSlot, service: { user_id: user.id }
      can :manage, Booking, service_provider_id: user.service_provider&.user_id

    when 'customer'
      can :read, Service
      can :read, ServiceAvailableSlot
      can :create, Booking
      can :read, Booking, customer_id: user.customer&.user_id
      can :destroy, Booking, customer_id: user.customer&.user_id
    end
  end
end
