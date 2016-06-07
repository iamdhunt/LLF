ActiveAdmin.register Medium do

	filter :id
	filter :member
	filter :asset_content_type
	filter :asset_file_size
	filter :created_at

	index do
		selectable_column
		column :id
		column :asset_file_name
		column :asset_content_type
		column :link
		column :created_at
		default_actions
	end

	controller do

		def show
			@medium = Medium.find(params[:id])
		end

		def edit
			@medium = Medium.find(params[:id])
		end

		def destroy
			@medium = Medium.find(params[:id])
			@activity = Activity.find_by_targetable_id(params[:id])
		    if @activity
		      @activity.destroy
		    end
			@medium.destroy

			respond_to do |format|
		      format.html { redirect_to admin_media_path, alert: "Media was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
