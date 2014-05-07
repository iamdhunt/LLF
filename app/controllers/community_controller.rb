class CommunityController < ApplicationController

  def community
  	@activities = Activity.select("activities.*, COUNT(votes.id) vote_count").joins(:votes).group("activities.id").order("created_at desc").page(params[:page]).per_page(72)
  	@media = Medium.select("media.*, COUNT(votes.id) vote_count").joins(:votes).group("media.id").order('created_at desc').page(params[:page]).per_page(70)
  end

end
