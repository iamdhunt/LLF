class CommunityController < ApplicationController

  def community
  	@activities = Activity.joins(:votes).group("activities.id").having("count(votes.id) >= ?", 1).order("created_at desc").page(params[:page]).per_page(72)
  	@media = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 1).order('created_at desc').page(params[:page]).per_page(70)

  	respond_to do |format|
	    format.html
		format.js
	end
  end

end
