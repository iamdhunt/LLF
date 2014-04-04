class CommunityController < ApplicationController

  def community
  	@activities = Activity.order("created_at desc").page(params[:page]).per_page(72)
  end

  def stream
  	@activities = Activity.order("created_at desc").page(params[:page]).per_page(72)
  end

  def media
  	@media = Medium.order('created_at desc').page(params[:page]).per_page(60)
  end

end
