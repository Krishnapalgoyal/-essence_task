Rails.application.routes.draw do
  get 'home/index'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: {
  registrations: 'users/registrations'
}

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  namespace :service_providers do
    get 'dashboard', to: 'dashboard#index'

    resources :services do
      resources :service_available_slots
    end
  end

  namespace :customers do
    get 'dashboard', to: 'dashboard#index'
    resources :services, only: [:index, :show] do
      resources :service_available_slots, only: [:index] do
        post 'book', on: :member
      end
    end
  end
  root "home#index"
end
