class ProfilesController < ApplicationController
 
 layout "profile"

  def show
  	@status = Status.new
    @status.build_document
  	@member = Member.find_by_user_name(params[:id]) 
  	if @member == current_member       
      params[:page] ||= 1
      @activities = Activity.for_member(current_member, params)
  		render action: :show
  	elsif @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(21)
      render action: :show
    else 
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  def stream
    @status = Status.new
    @status.build_document
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member 
      params[:page] ||= 1
      @activities = Activity.for_member(current_member, params)
      render action: :show
    elsif @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(21)
      render action: :show
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def personal
    @status = Status.new
    @status.build_document
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @activities = @member.activities.order("created_at desc").page(params[:page]).per_page(21)
      render action: :show
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def my_stream
    @status = Status.new
    @status.build_document
    @member = Member.find_by_user_name(params[:id])
    if @member == current_member 
      params[:page] ||= 1
      @activities = Activity.for_member(current_member, params)
      render action: :show
    else 
      redirect_to profile_stream_path(@member)
    end
  end

  def stream_fav
    @status = Status.new
    @status.build_document
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @activities = @member.get_up_voted Activity.page(params[:page]).per_page(25)
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
    @medium = current_member.medium.new
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @media = @member.medium.order('created_at desc').page(params[:page]).per_page(25) 
      render action: :media
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def media_fav
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @media = @member.get_up_voted Medium.page(params[:page]).per_page(25)
      render action: :media_fav
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def followers
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @followers = @member.followers(:order => 'created_at DESC').paginate(page: params[:page], per_page: (36))
      render action: :followers
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def following
    @member = Member.find_by_user_name(params[:id])
    @following = @member.following_members(:order => 'created_at DESC').paginate(page: params[:page], per_page: (36))
    if @member  
      render action: :following
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
  
end
