# app/models/service_available_slot.rb
class ServiceAvailableSlot < ApplicationRecord
  belongs_to :service
  has_one :booking

  validates :start_time, :end_time, presence: true
  validate :start_must_be_before_end
  validate :no_overlap
  validate :start_time_must_be_in_future

  scope :available, -> { left_joins(:booking).where(bookings: { id: nil }).where('end_time > ?', Time.current) }

  private

  def start_must_be_before_end
    if start_time.present? && end_time.present? && start_time >= end_time
      errors.add(:start_time, "must be before end time")
    end
  end

  def start_time_must_be_in_future
    if start_time.present? && start_time < Time.current
      errors.add(:start_time, "must be in the future")
    end
  end

  def no_overlap
    return unless start_time && end_time

    overlaps = ServiceAvailableSlot
      .where(service_id: service_id)
      .where.not(id: id) # exclude self for updates
      .where("start_time < ? AND end_time > ?", end_time, start_time)

    if overlaps.exists?
      errors.add(:base, "This time slot overlaps with another existing slot for this service.")
    end
  end
end
