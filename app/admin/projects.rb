ActiveAdmin.register Project do

	filter :id
	filter :member
	filter :name
	filter :category
	filter :city
	filter :created_at

	index do
		selectable_column
		column :id
		column :name
		column :category
		column :website
		column :city
		column :created_at
		default_actions
	end

	controller do

		def show
			@project = Project.find_by_permalink(params[:id])
		end

		def edit
			@project = Project.find_by_permalink(params[:id])
		end

		def destroy
			@project = Project.find_by_permalink(params[:id])
			@project.destroy

			respond_to do |format|
		      format.html { redirect_to llf_adm_projects_path, alert: "Project was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
