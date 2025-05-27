class Service < ApplicationRecord
  belongs_to :service_provider
  has_many :service_available_slots
  has_many :booking

  def self.ransackable_associations(auth_object = nil)
    ["service_provider"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "service_provider_id", "updated_at"]
  end
end
