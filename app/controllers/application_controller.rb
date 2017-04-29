class ApplicationController < ActionController::Base

	

	protect_from_forgery

		def after_sign_in_path_for(resource)
		 profile_path(current_member)
		end

		def after_sign_up_path_for(resource)
		  profile_path(current_member)
		end
	 
		def after_update_path_for(resource)
	      profile_path(current_member)
	    end

	    def target_activity(targetable, action = params[:action])
		    current_member.activities.create! action: action, targetable: targetable
		end

	private
                                                                                 
		def with_timezone
		    timezone = Time.find_zone(cookies[:timezone])
		    Time.use_zone(timezone) { yield }
		end

end
