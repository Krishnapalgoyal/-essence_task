class ServiceProvider < ApplicationRecord
  belongs_to :user
  has_many :services
  has_many :bookings, through: :services

  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "updated_at", "user_id"]
  end
end
