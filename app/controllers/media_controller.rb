class MediaController < ApplicationController

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy]
  before_filter :find_member
  before_filter :find_media, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html]
  end

  # GET /media
  # GET /media.json
  def index
    if member_signed_in?
      @medium = current_member.medium.new
    end
    @search = Medium.solr_search do
      fulltext params[:media]
      facet(:marker_list, :limit => 85, :sort => :count)
        with(:marker_list, params[:tag]) if params[:tag].present?
    end
    @query = params[:media]
    @facet = params[:tag]
    @results = Medium.where(id: @search.results.map(&:id)).page(params[:page]).per_page(63)
    @media = Medium.order('created_at desc').page(params[:page]).per_page(6)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /media/1
  # GET /media/1.json
  def show
    if member_signed_in?
      @media = current_member.medium.new
    end
    @medium = Medium.find(params[:id])
    if @medium
      @commentable = @medium
      @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
      @comment = Comment.new
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @medium }
      end
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  # GET /media/new
  # GET /media/new.json
  def new
    @medium = current_member.medium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
    end
  end

  # GET /media/1/edit
  def edit
    
  end

  # POST /media
  # POST /media.json
  def create
    @medium = Medium.new(params[:medium])
    @medium.member = current_member

    respond_to do |format|
      if @medium.save
        @activity = current_member.create_activity(@medium, 'created')
        format.html { redirect_to profile_media_path(current_member) }
        format.json { render json: @medium, status: :created, location: @medium }
        format.js
      else
        format.html { redirect_to profile_media_new_path(current_member) }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def cancel

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
      format.js
    end
  end

  # PUT /media/1
  # PUT /media/1.json
  def update

    respond_to do |format|
      if @medium.update_attributes(params[:medium])
        format.html { redirect_to @medium }
        format.json { head :no_content }
        format.js   { render :js => "window.location.href = ('#{medium_path(@medium)}');"}
      else
        format.html { render action: "edit" }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    @medium.destroy

    respond_to do |format|
      format.html { redirect_to profile_media_path(current_member) }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @medium = Medium.find(params[:id])
    if current_member.voted_up_on? @medium
      @medium.unliked_by current_member
    else 
      @medium.liked_by current_member
    end
    respond_to do |format|
        format.html { redirect_to :back }
        format.js
    end
  end

  def popular
    if member_signed_in?
      @medium = current_member.medium.new
    end
    @search = Medium.solr_search do
      fulltext params[:media]
      facet(:marker_list, :limit => 85, :sort => :count)
      with(:marker_list, params[:tag]) if params[:tag].present?
    end
    @query = params[:media]
    @facet = params[:tag]
    @results = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 1).where(id: @search.results.map(&:id)).page(params[:page]).per_page(63)
    @media = Medium.joins(:votes).group("media.id").having("count(votes.id) >= ?", 1).order("created_at desc").page(params[:page]).per_page(63)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @media }
    end
  end

  def media_cancel
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
      format.js
    end
  end 

  def url_options
    { user_name: params[:user_name] }.merge(super)
  end 

  private
  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

  def find_media
    @medium = current_member.medium.find(params[:id])
  end 

end
