class PagesController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html]
  end

  def faqs
  end
  
  def terms
  end

  def privacy
  end

  def rules
  end

  def community
    @activities = Activity.joins(:votes).group("activities.id").having("count(votes.id) >= ?", 1).order("created_at desc").where(:created_at => 12.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(2)
    @media = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 1).order('created_at desc').where(:created_at => 12.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(2)
  end

  def trending
    @activities = Activity.joins(:votes).group("activities.id").having("count(votes.id) >= ?", 1).order("created_at desc").where(:created_at => 6.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(60)
    @media = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 1).order('created_at desc').where(:created_at => 6.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(70)
  end
end
