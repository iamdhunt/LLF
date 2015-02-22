class CommunityController < ApplicationController

  def community
  	@activities = Activity.joins(:votes).group("activities.id").having("count(votes.id) >= ?", 1).order("created_at desc").where(:created_at => 6.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(60)
  	@media = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 1).order('created_at desc').where(:created_at => 6.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(70)

  	respond_to do |format|
	    format.html
		format.js
	end
  end

end
