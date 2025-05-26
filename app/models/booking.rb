class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :service_provider
  belongs_to :customer
  belongs_to :service_available_slot
end
