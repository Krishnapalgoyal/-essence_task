class ServiceAvailableSlot < ApplicationRecord
  belongs_to :service
  has_one :booking

  validates :start_time, :end_time, presence: true

  scope :available, -> { left_outer_joins(:booking).where(bookings: { id: nil }) }
end
