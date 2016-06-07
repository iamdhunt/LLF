ActiveAdmin.register Member do

	filter :id
	filter :user_name
	filter :full_name
	filter :email
	filter :city
	filter :state
	filter :country
	filter :last_sign_in_at
	filter :created_at

	index do
		selectable_column
		column :id
		column :user_name
		column :full_name
		column :email
		column :created_at
		column :last_sign_in_at
		default_actions
	end

	controller do

		def show
			@member = Member.find_by_user_name(params[:id])
		end

		def edit
			@member = Member.find_by_user_name(params[:id])
		end

		def update
			@member = Member.find_by_user_name(params[:id])

			respond_to do |format|
		      if @member.update_attributes(params[:comment])
		        format.html { redirect_to admin_member_path, alert: "Member was successfully updated." }
			     format.json { head :no_content }
		      else
		        render :edit
		      end
		    end
		end

	end

	form do |f|
	  f.inputs "Edit Member" do
	    f.input :admin, as: :boolean
	    f.input :verified, as: :boolean
	    f.actions :commit
	  end
	end
  
end
