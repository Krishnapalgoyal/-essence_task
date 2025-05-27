# app/controllers/service_providers/services_controller.rb
module ServiceProviders
  class ServicesController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_service_provider!
    before_action :set_service, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

    def index
      @services = current_user.service_provider.services
    end

    def show; end

    def new
      @service = current_user.service_provider.services.build
    end

    def create
      @service = current_user.service_provider.services.build(service_params)
      if @service.save
        redirect_to service_providers_services_path, notice: "Service created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit; end

    def update
      if @service.update(service_params)
        redirect_to service_providers_services_path, notice: "Service updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @service.destroy
      redirect_to service_providers_services_path, notice: "Service deleted successfully."
    end

    private

    def authorize_service_provider!
      redirect_to root_path, alert: "Access denied" unless current_user.role == "service_provider"
    end

    def set_service
      @service = current_user.service_provider.services.find(params[:id])
    end

    def service_params
      params.require(:service).permit(:name, :description)
    end
  end
end
