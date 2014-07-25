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
		column :asset_file_size
		column :created_at
		default_actions
	end

	controller do

		def show
			@medium = Medium.find_by_permalink(params[:id])
		end

		def edit
			@medium = Medium.find_by_permalink(params[:id])
		end

		def destroy
			@medium = Medium.find_by_permalink(params[:id])
			@medium.destroy

			respond_to do |format|
		      format.html { redirect_to llf_adm_media_path, alert: "Media was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
