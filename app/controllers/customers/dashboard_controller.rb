module Customers
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_customer!
    

    def index
      @services = Service.includes(:service_provider)
    end

    private

    def authorize_customer!
      redirect_to root_path unless current_user.role == 'customer'
    end
  end
end
