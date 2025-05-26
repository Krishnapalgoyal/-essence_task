ActiveAdmin.register ServiceAvailableSlot do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :service_id, :start_time, :end_time
  #
  # or
  #
  # permit_params do
  #   permitted = [:service_id, :start_time, :end_time]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
