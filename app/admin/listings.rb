ActiveAdmin.register Listing do

	filter :id
	filter :member
	filter :price
	filter :title
	filter :category
	filter :created_at

	index do
		selectable_column
		column :id
		column :title
		column :link
		column :category
		column :price
		column :created_at
		default_actions
	end

	controller do

		def show
			@listing = Listing.find_by_permalink(params[:id])
		end

		def edit
			@listing = Listing.find_by_permalink(params[:id])
		end

		def destroy
			@listing = Listing.find_by_permalink(params[:id])
			@listing.destroy

			respond_to do |format|
		      format.html { redirect_to llf_adm_listings_path, alert: "Listing was successfully destroyed." }
		      format.json { head :no_content }
		    end
		end

	end
  
end
