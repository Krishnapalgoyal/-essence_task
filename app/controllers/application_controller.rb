class ApplicationController < ActionController::Base
  protected

  def after_sign_in_path_for(resource)
    if resource.is_a?(AdminUser)
      admin_root_path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    after_sign_in_path_for(resource)
  end
end
