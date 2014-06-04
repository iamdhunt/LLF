class CommunityController < ApplicationController

  def community
  	@activities = Activity.joins(:votes).group("activities.id").having("count(votes.id) >= ?", 3).order("created_at desc").where(:created_at => 3.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(72)
  	@media = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 3).order('created_at desc').where(:created_at => 3.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(70)
  end

end
