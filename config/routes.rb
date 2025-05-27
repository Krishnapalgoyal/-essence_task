Rails.application.routes.draw do
  get 'home/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  namespace :service_providers do
    get 'dashboard', to: 'dashboard#index'

    resources :services do
      resources :service_available_slots
    end

    get 'bookings/requests', to: 'bookings#requests', as: 'booking_requests'
    patch 'bookings/:id/accept', to: 'bookings#accept', as: 'accept_booking'
    patch 'bookings/:id/reject', to: 'bookings#reject', as: 'reject_booking'
  end

  namespace :customers do
    get 'dashboard', to: 'dashboard#index'

    resources :services, only: [:index, :show] do
      resources :service_available_slots, only: [:index] do
        resources :bookings, only: [:index, :new, :create, :destroy]
      end
    end

    resources :bookings, only: [:index, :show]
  end

  root "home#index"
end
