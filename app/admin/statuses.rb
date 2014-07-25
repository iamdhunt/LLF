ActiveAdmin.register Status do

	filter :id
	filter :member
	filter :created_at

	index do
		selectable_column
		column :id
		column :content
		column :created_at
		default_actions
	end

	controller do

		def show
			@status = Status.find_by_permalink(params[:id])
		end

		def edit
			@status = Status.find_by_permalink(params[:id])
		end

		def destroy
			@status = Status.find_by_permalink(params[:id])
			@status.destroy

			respond_to do |format|
		      format.html { redirect_to llf_adm_statuses_path, alert: "Status was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
