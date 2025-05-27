class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "You are not authorized to access this page."
  end
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
