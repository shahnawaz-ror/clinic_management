class ApplicationController < ActionController::Base
	before_action :authenticate_user!

	def after_sign_in_path_for(resource)
		if resource.role == 'doctor'
      # Redirect doctors to the graph page
      doctors_graph_path # Assuming you have a route for doctor graph page
  elsif resource.role == 'receptionist'
      # Redirect receptionists to the receptionist index path
      receptionists_path # Assuming you have a route for the receptionists index
  else
      # For other users (e.g., admin), use the default redirect behavior
      super
  end
end
end
