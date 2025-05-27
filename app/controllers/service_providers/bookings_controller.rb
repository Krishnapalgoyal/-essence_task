module ServiceProviders
  class BookingsController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_provider!
    load_and_authorize_resource

    def requests
      @bookings = current_user.service_provider.bookings.includes(:service, :customer).requested
    end

    def accept
      booking = current_user.service_provider.bookings.find(params[:id])
      booking.update(status: :confirmed)
      redirect_to service_providers_booking_requests_path, notice: "Booking accepted."
    end

    def reject
      booking = current_user.service_provider.bookings.find(params[:id])
      booking.update(status: :canceled)
      redirect_to service_providers_booking_requests_path, alert: "Booking rejected."
    end

    private

    def authorize_provider!
      redirect_to root_path unless current_user.role == 'service_provider'
    end
  end
end
