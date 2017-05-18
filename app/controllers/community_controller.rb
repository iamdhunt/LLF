class CommunityController < ApplicationController


  	def index
	    @activities = Activity.order("created_at desc")
		    .where(:created_at => 12.months.ago..Time.now)
		    .page(params[:page]).per_page(30)

			if member_signed_in?
				redirect_to profile_path(current_member)
			else
				respond_to do |format|
					format.html
			        format.js
			    end
		    end
	end

end
