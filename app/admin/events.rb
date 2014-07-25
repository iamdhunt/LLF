ActiveAdmin.register Event do

	filter :id
	filter :member
	filter :name
	filter :category
	filter :start_date
	filter :end_date
	filter :start_time
	filter :end_time
	filter :location
	filter :city
	filter :state 
	filter :country
	filter :created_at

	index do
		selectable_column
		column :id
		column :name
		column :category
		column :start_date
		column :end_date
		column :start_time
		column :end_time
		column :created_at
		default_actions
	end

	controller do

		def show
			@event = Event.find_by_permalink(params[:id])
		end

		def edit
			@event = Event.find_by_permalink(params[:id])
		end

		def destroy
			@event = Event.find_by_permalink(params[:id])
			@event.destroy

			respond_to do |format|
		      format.html { redirect_to llf_adm_events_path, alert: "Event was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
