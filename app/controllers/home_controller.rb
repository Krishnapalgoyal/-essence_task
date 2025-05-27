class HomeController < ApplicationController
  before_action :check_current_user

  def index
    if current_user.is_service_provider?
      redirect_to service_providers_dashboard_path
    else
      redirect_to customers_dashboard_path
    end
  end

  private
  def check_current_user
    if !current_user
      redirect_to new_user_session_path
    end
  end
end
