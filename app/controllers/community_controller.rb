class CommunityController < ApplicationController


  	def index
	    @activities = Activity.joins(:votes).group("activities.id")
		    .having("count(votes.id) >= ?", 1).order("created_at desc")
		    .where(:created_at => 12.months.ago..Time.now)
		    .page(params[:page]).per_page(60)

		respond_to do |format|
			format.html
	        format.js
	    end
	end

end
