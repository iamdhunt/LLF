class CommunityController < ApplicationController

  	def community
	    @activities = Activity.joins(:votes).group("activities.id")
		    .having("count(votes.id) >= ?", 1).order("created_at desc")
		    .where(:created_at => 12.months.ago..Time.zone.now.to_date)
		    .page(params[:page]).per_page(60)
	end

end
