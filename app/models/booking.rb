class Booking < ApplicationRecord
  enum status: { requested: 0, confirmed: 1, completed: 2, canceled: 3 }

  belongs_to :service
  belongs_to :service_provider
  belongs_to :customer
  belongs_to :service_available_slot

  validate :slot_is_available

  private

  def slot_is_available
    errors.add(:base, 'Slot already booked') if !service_available_slot.booking.present?
  end

  def self.ransackable_associations(auth_object = nil)
    ["customer", "service", "service_available_slot", "service_provider"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "service_available_slot_id", "service_id", "service_provider_id", "status", "updated_at"]
  end
end
