class PagesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html]
  end

  def faqs
  end

  def faqs_basics
  end

  def faqs_community
  end

  def faqs_media
  end

  def faqs_events
  end

  def faqs_projects
  end

  def faqs_market
  end
  
  def terms
  end

  def privacy
  end

  def rules
  end

  def trending
    @activities = Activity.joins(:votes)
      .group("activities.id").having("count(votes.id) >= ?", 1)
      .where(:created_at => 6.months.ago..Time.zone.now.to_date)
      .order_by_rand.limit(100).all
  end
end
