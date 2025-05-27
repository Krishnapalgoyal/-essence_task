class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, service_provider: 1 }

  has_one :service_provider
  has_one :customer

  after_create :set_role

  def is_service_provider?
    if role == "service_provider"
      return true
    end
  end

  private
  def set_role
    if is_service_provider?
      build_service_provider
    else
      build_customer
    end
    save
  end
end
