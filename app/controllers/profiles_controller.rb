class ProfilesController < ApplicationController
 
 layout "profile"

 rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html, :layout => false]
  end

  def show
  	@member = Member.find_by_user_name(params[:id]) 
  	if @member == current_member
      @medium = current_member.medium.new
      @status = current_member.statuses.new
      @status.build_document      
      @activities = Activity.order("created_at desc").page(params[:page]).per_page(30)

      respond_to do |format|
        format.html
        format.js
      end
  	elsif @member
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(30)

      respond_to do |format|
        format.html
        format.js
      end
    else
  		render file: 'public/404', status: 404, :layout => false
  	end
  end

  def stream
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @status = current_member.statuses.new
      @status.build_document 
      @activities = Activity.order("created_at desc").page(params[:page]).per_page(30)
      
      respond_to do |format|
        format.html
        format.js
      end
    elsif @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(30)

      respond_to do |format|
        format.html
        format.js
      end
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def personal
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @status = current_member.statuses.new
      @status.build_document
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(30)
    elsif @member 
      redirect_to profile_stream_path(@member)
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def stream_fav
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @activities = @member.get_up_voted Activity.order("created_at desc").page(params[:page]).per_page(30)
      render action: :show_fav
    elsif @member 
      @activities = @member.get_up_voted Activity.order("created_at desc").page(params[:page]).per_page(30)
      render action: :show_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def stream_fol
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      following_ids = @member.following_members.map(&:id)
      @activities = Activity.where("member_id in (?)", following_ids).order("created_at desc").page(params[:page]).per_page(30)
      respond_to do |format|
        format.html
        format.js
      end
    elsif @member 
      redirect_to profile_stream_path(@member)
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def stream_pop
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @activities = Activity.joins(:votes).group("activities.id")
        .having("count(votes.id) >= ?", 1).order("created_at desc")
        .page(params[:page]).per_page(30)
      respond_to do |format|
        format.html
        format.js
      end
    elsif @member 
      redirect_to profile_stream_path(@member)
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def media_new
    @medium = current_member.medium.new
    @member = Member.find_by_user_name(params[:id])
    if @member && @member == current_member
      render action: :media_new
    else
      redirect_to profile_media_path(@member)
    end
  end

  def media  
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @media = @member.medium.order('created_at desc').page(params[:page]).per_page(25) 
      render action: :media
    elsif @member
      @media = @member.medium.order('created_at desc').page(params[:page]).per_page(25) 
      render action: :media
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def media_fav
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @media = @member.get_up_voted Medium.order("created_at desc").page(params[:page]).per_page(25)
      render action: :media_fav
    elsif @member
      @media = @member.get_up_voted Medium.order("created_at desc").page(params[:page]).per_page(25)
      render action: :media_fav
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def media_cancel
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
      format.js
    end
  end 

  def followers
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @followers = @member.followers(:order => 'follows.id DESC').paginate(page: params[:page], per_page: (35))
      render action: :followers
    elsif @member 
      @followers = @member.followers(:order => 'follows.id DESC').paginate(page: params[:page], per_page: (35))
      render action: :followers
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def following
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @following = @member.following_members(:order => 'following.id DESC').paginate(page: params[:page], per_page: (35))
    elsif @member  
      @following = @member.following_members(:order => 'following.id DESC').paginate(page: params[:page], per_page: (35))
      render action: :following
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def projects
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @projects = @member.projects.order("updated_at desc").paginate(page: params[:page], per_page: (10))
      render action: :projects
    elsif @member 
      @projects = @member.projects.order("updated_at desc").paginate(page: params[:page], per_page: (10))
      render action: :projects
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def projects_following
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @following = @member.following_projects(:order => 'updated_at DESC').paginate(page: params[:page], per_page: (10))
      render action: :projects_following
    elsif @member 
      @following = @member.following_projects(:order => 'updated_at DESC').paginate(page: params[:page], per_page: (10))
      render action: :projects_following
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def projects_fav
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @projects = @member.get_up_voted Project.order("updated_at desc").page(params[:page]).per_page(10)
      render action: :projects_fav
    elsif @member 
      @projects = @member.get_up_voted Project.order("updated_at desc").page(params[:page]).per_page(10)
      render action: :projects_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def events
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @events = @member.events.order("updated_at desc").paginate(page: params[:page], per_page: (10))
      @past = @member.events.order("start_date desc").where("start_date < ? AND end_date < ?", Date.today, Date.today).limit(12).all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json {  }
      end
    elsif @member 
      @events = @member.events.order("updated_at desc").paginate(page: params[:page], per_page: (10))
      @past = @member.events.order("start_date desc").where("start_date < ? AND end_date < ?", Date.today, Date.today).limit(12).all
      
      respond_to do |format|
        format.html # index.html.erb
        format.json {  }
      end
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def events_past
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @events = @member.events.order("start_date desc").where("start_date < ? AND end_date < ?", Date.today, Date.today).paginate(page: params[:page], per_page: (30))
      render action: :events_past
    elsif @member 
      @events = @member.events.order("start_date desc").where("start_date < ? AND end_date < ?", Date.today, Date.today).paginate(page: params[:page], per_page: (30))
      render action: :events_past
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def events_current
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @events = @member.events.order("start_date desc").where("start_date >= ? OR end_date >= ?", Date.today, Date.today).paginate(page: params[:page], per_page: (30))
      render action: :events_current
    elsif @member 
      @events = @member.events.order("start_date desc").where("start_date >= ? OR end_date >= ?", Date.today, Date.today).paginate(page: params[:page], per_page: (30))
      render action: :events_current
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def events_following
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @following = @member.following_events(:order => 'updated_at desc').paginate(page: params[:page], per_page: (10))
      render action: :events_following
    elsif @member 
      @following = @member.following_events(:order => 'updated_at desc').paginate(page: params[:page], per_page: (10))
      render action: :events_following
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def events_fav
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @events = @member.get_up_voted Event.order("created_at desc").page(params[:page]).per_page(10)
      render action: :events_fav
    elsif @member 
      @events = @member.get_up_voted Event.order("created_at desc").page(params[:page]).per_page(10)
      render action: :events_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def market
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @listings = @member.listings.order('created_at desc').page(params[:page]).per_page(10)
      render action: :market
    elsif @member 
      @listings = @member.listings.order('created_at desc').page(params[:page]).per_page(10)
      render action: :market
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def market_fav
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @listings = @member.get_up_voted Listing.order("created_at desc").page(params[:page]).per_page(10)
      render action: :market_fav
    elsif @member 
      @listings = @member.get_up_voted Listing.order("created_at desc").page(params[:page]).per_page(10)
      render action: :market_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
  
end
