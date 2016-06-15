class RegistrationsController < Devise::RegistrationsController

	def settings
		@member = current_member
		if @member 
			render :settings
		else
			render file: 'public/404', status: 404, formats: [:html]
		end 
	end

	def avatar
		@member = current_member
		if @member 
			render :avatar
		else
			render file: 'public/404', status: 404, formats: [:html]
		end 
	end

	def update
		respond_to do |format|
	    	# required for settings form to submit when password is left blank
		    if params[:member][:password].blank?
			    params[:member].delete(:password)
			    params[:member].delete(:password_confirmation)
			end

		    @member = Member.find(current_member.id)
		    if @member.update_attributes(params[:member])
				# Sign in the member bypassing validation in case his password changed
				sign_in @member, :bypass => true 
				format.html { redirect_to root_path }
				format.js { render :js => "window.location.href = ('#{profile_path(@member)}');" } 
		    else
		    	format.html render "edit"
		    	format.js { render 'update.js.erb' }
		    end
		end 
  	end

  	def create
	    build_resource(sign_up_params)

	    respond_to do |format|
		    if resource.save
		        yield resource if block_given?
		        if resource.active_for_authentication?
		            sign_up(resource_name, resource)
		            format.js { render :js => "window.location.href = ('#{after_sign_up_path_for(resource)}');" }
		        else
		            set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
		            expire_data_after_sign_in!
		            respond_with resource, location: after_inactive_sign_up_path_for(resource)
		        end
		    else
		        clean_up_passwords resource
		        format.js { render 'create.js.erb' } 
		    end
		end
	end

end