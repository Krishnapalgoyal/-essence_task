module Customers
  class ServiceAvailableSlotsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_customer!
    before_action :set_service
    load_and_authorize_resource

    def index
      @slots = @service.service_available_slots.available.order(:start_time)
    end

    private

    def authorize_customer!
      redirect_to root_path unless current_user.role == 'customer'
    end

    def set_service
      @service = Service.find(params[:service_id])
    end
  end
end
