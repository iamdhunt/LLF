class PagesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html]
  end
  
  def spotlights
  end

  def contests
  end

  def faqs
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
