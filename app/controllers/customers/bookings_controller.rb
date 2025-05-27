module Customers
  class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_customer!
    before_action :set_slot, only: [:new, :create]

    def index
      @bookings = current_user&.customer&.bookings&.includes(:service, :service_available_slot)
    end

    def show
      @booking = current_user&.customer&.bookings&.find(params[:id])
    end

    def new
      @booking = Booking.new
    end

    def create
      if !@slot.booking.present?
        @booking = Booking.new(
          service: @slot.service,
          service_available_slot: @slot,
          service_provider: @slot.service.service_provider,
          customer: current_user.customer,
          status: 'requested'
        )

        if @booking.save
          redirect_to customers_bookings_path, notice: 'Booking created successfully.'
        else
          render :new, status: :unprocessable_entity
        end
      else
        redirect_to customers_service_service_available_slots_path(@slot.service), alert: 'Slot already booked.'
      end
    end

    def destroy
      @booking = current_user.customer.bookings.find(params[:id])
      if @booking.may_cancel? || @booking.requested? || @booking.confirmed?
        @booking.update(status: :canceled)
        redirect_to customers_bookings_path, notice: "Booking canceled."
      else
        redirect_to customers_bookings_path, alert: "Cannot cancel this booking."
      end
    end

    private

    def authorize_customer!
      redirect_to root_path unless current_user.role == 'customer'
    end

    def set_slot
      @slot = ServiceAvailableSlot.find(params[:service_available_slot_id])
    end
  end
end
