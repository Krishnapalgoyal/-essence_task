# app/controllers/service_providers/service_available_slots_controller.rb
module ServiceProviders
  class ServiceAvailableSlotsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_service_provider!
    before_action :set_service
    before_action :set_slot, only: [:edit, :update, :destroy, :show]
    load_and_authorize_resource

    def index
      @slots = @service.service_available_slots.order(:start_time)
    end

    def show
    end

    def new
      @slot = @service.service_available_slots.build
    end

    def create
      @slot = @service.service_available_slots.build(slot_params)
      if @slot.save
        redirect_to service_providers_service_service_available_slots_path(@service), notice: "Slot created successfully."
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @slot.update(slot_params)
        redirect_to service_providers_service_service_available_slots_path(@service), notice: "Slot updated successfully."
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @slot.destroy
      redirect_to service_providers_service_service_available_slots_path(@service), notice: "Slot deleted successfully."
    end

    private

    def authorize_service_provider!
      redirect_to root_path, alert: "Access denied" unless current_user.role == 'service_provider'
    end

    def set_service
      @service = current_user.service_provider.services.find(params[:service_id])
    end

    def set_slot
      @slot = @service.service_available_slots.find(params[:id])
    end

    def slot_params
      params.require(:service_available_slot).permit(:start_time, :end_time)
    end
  end
end
pro