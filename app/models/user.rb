class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { customer: 0, service_provider: 1 }

  has_one :service_provider
  has_one :customer

  after_create :set_role


  private
  def set_role
    if role == "service_provider"
      user = service_providers.new()
    else
      user = customers.new()
    end
    user.save
  end
end
