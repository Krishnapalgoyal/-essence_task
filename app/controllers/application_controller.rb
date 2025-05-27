class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    case resource.role
    when "service_provider"
      service_providers_dashboard_path
    when "customer"
      customers_dashboard_path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
end
