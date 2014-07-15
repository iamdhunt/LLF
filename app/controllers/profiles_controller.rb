class ProfilesController < ApplicationController
 
 layout "profile"

 respond_to :html, :json, only: [:show, :stream, :my_stream]

  def show
  	@member = Member.find_by_user_name(params[:id]) 
  	if @member == current_member
      @status = current_member.statuses.new
      @status.build_document      
      params[:page] ||= 1
      @activities = Activity.for_member(current_member, params)
      respond_with @activities
  	elsif @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(36)
      render action: :show
    else 
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  def stream
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @status = current_member.statuses.new
      @status.build_document 
      params[:page] ||= 1
      @activities = Activity.for_member(current_member, params)
      respond_with @activities
    elsif @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(36)
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def personal
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @status = current_member.statuses.new
      @status.build_document
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(36)
      render action: :show
    elsif @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(36)
      render action: :show
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def my_stream
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @status = current_member.statuses.new
      @status.build_document 
      params[:page] ||= 1
      @activities = Activity.for_member(current_member, params)
      respond_with @activities
    else 
      redirect_to profile_stream_path(@member)
    end
  end

  def stream_fav
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @activities = @member.get_up_voted Activity.order("created_at desc").page(params[:page]).per_page(36)
      render action: :show_fav
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
      @media = @member.medium.order('created_at desc').page(params[:page]).per_page(40) 
      render action: :media
    elsif @member
      @media = @member.medium.order('created_at desc').page(params[:page]).per_page(40) 
      render action: :media
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def media_fav
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member
      @medium = current_member.medium.new
      @media = @member.get_up_voted Medium.order("created_at desc").page(params[:page]).per_page(40)
      render action: :media_fav
    elsif @member
      @media = @member.get_up_voted Medium.order("created_at desc").page(params[:page]).per_page(40)
      render action: :media_fav
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def followers
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @followers = @member.followers(:order => 'follows.id DESC').paginate(page: params[:page], per_page: (72))
      render action: :followers
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def following
    @member = Member.find_by_user_name(params[:id])
    @following = @member.following_members(:order => 'following.id DESC').paginate(page: params[:page], per_page: (72))
    if @member  
      render action: :following
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def projects
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @projects = @member.projects.order("created_at desc").paginate(page: params[:page], per_page: (24))
      render action: :projects
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def projects_following
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @following = @member.following_projects(:order => 'created_at DESC').paginate(page: params[:page], per_page: (24))
      render action: :projects_following
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def projects_fav
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @projects = @member.get_up_voted Project.order("created_at desc").page(params[:page]).per_page(24)
      render action: :projects_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def events
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @events = @member.events.order("start_date asc").where("start_date >= ? OR end_date >= ?", Date.today, Date.today).paginate(page: params[:page], per_page: (24))
      render action: :events
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def events_past
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @events = @member.events.order("start_date asc").where("start_date < ? AND end_date < ?", Date.today, Date.today).paginate(page: params[:page], per_page: (24))
      render action: :events_past
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def events_following
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @following = @member.following_events(:order => 'start_date asc').where("start_date >= ? OR end_date >= ?", Date.today, Date.today).paginate(page: params[:page], per_page: (24))
      render action: :events_following
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def events_fav
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @events = @member.get_up_voted Event.order("start_date asc").page(params[:page]).per_page(24)
      render action: :events_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end 

  def market
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @listings = @member.listings.order('created_at desc').page(params[:page]).per_page(24)
      render action: :market
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def market_fav
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @listings = @member.get_up_voted Listing.order("created_at desc").page(params[:page]).per_page(24)
      render action: :market_fav
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
  
end
