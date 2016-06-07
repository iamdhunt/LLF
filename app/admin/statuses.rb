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
			@status = Status.find(params[:id])
		end

		def edit
			@status = Status.find(params[:id])
		end

		def destroy
			@status = Status.find(params[:id])
			@activity = Activity.find_by_targetable_id(params[:id])
		    if @activity
		      @activity.destroy
		    end
			@status.destroy

			respond_to do |format|
		      format.html { redirect_to admin_statuses_path, alert: "Status was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
