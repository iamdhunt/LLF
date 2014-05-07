class PagesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html]
  end

  def faqs
    @activities = Activity.select("activities.*, COUNT(votes.id) vote_count").joins(:votes).group("activities.id").order("created_at desc").limit(2)
    @media = Medium.select("media.*, COUNT(votes.id) vote_count").joins(:votes).group("media.id").order('created_at desc').limit(2)
  end

  def contact_us
  end

  def terms
  end

  def privacy
  end

  def rules
  end

  def brand_spotlights
  end

  def artist_spotlights
  end

  def music_spotlights
  end

  def member_spotlights
  end
end
