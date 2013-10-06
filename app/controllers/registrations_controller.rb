class RegistrationsController < Devise::RegistrationsController

	def settings
		@member = current_member
		if @member 
			render :settings
		else
			render file: 'public/404', status: 404, formats: [:html]
		end 
	end

	def update
    # required for settings form to submit when password is left blank
	    if params[:member][:password].blank?
	      params[:member].delete("password")
	      params[:member].delete("password_confirmation")
	    end

	    @member = Member.find(current_member.id)
	    if @member.update_attributes(params[:member])
	      set_flash_message :notice, :updated
	      # Sign in the member bypassing validation in case his password changed
	      sign_in @member, :bypass => true
	      redirect_to after_update_path_for(@member)
	    else
	      redirect_to :back, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.'
	    end
  	end

end