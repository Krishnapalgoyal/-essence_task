class ServiceAvailableSlot < ApplicationRecord
  belongs_to :service
  has_one :booking

  validates :start_time, :end_time, presence: true

  scope :available, -> { left_outer_joins(:booking).where(bookings: { id: nil }) }

  def self.ransackable_associations(auth_object = nil)
    ["booking", "service"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["booking", "service"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "end_time", "id", "id_value", "service_id", "start_time", "updated_at"]
  end
end
