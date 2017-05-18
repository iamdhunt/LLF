class EventsController < ApplicationController

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_event, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, :layout => false
  end

  # GET /events
  # GET /events.json
  def index
    @current = Event.order("start_date asc").where("start_date >= ? OR end_date >= ?", Date.today, Date.today).limit(20).all
    @past = Event.order("start_date desc").where("start_date < ? AND end_date < ?", Date.today, Date.today).limit(20).all
    @markers = Event.marker_counts.order('count DESC').limit(12)
    @events = Event.order('start_date asc').where("start_date >= ? OR end_date >= ?", Time.zone.now.to_date, Time.zone.now.to_date).page(params[:page]).per_page(20)
    @search = Event.solr_search do
      fulltext params[:events]
      any_of do
        with(:end_date).greater_than_or_equal_to(Time.zone.now.to_date)
      end 
      facet(:event_month, :sort => :count)
        with(:event_month, params[:month]) if params[:month].present?
      facet(:marker_list, :limit => 65, :sort => :count)
        with(:marker_list, params[:tag]) if params[:tag].present?
      facet(:location, :limit => 24, :sort => :count)
        with(:location, params[:locations]) if params[:locations].present?
    end
    @query = params[:events]
    @facet = params[:month]
    @tag_facet = params[:tag]
    @location_facet = params[:locations]
    @results = Event.where(id: @search.results.map(&:id)).page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events
  # GET /events.json
  def current
    @markers = Event.marker_counts.order('count DESC').limit(12)
    @events = Event.order('start_date asc').where("start_date >= ? OR end_date >= ?", Time.zone.now.to_date, Time.zone.now.to_date).page(params[:page]).per_page(20)
    @search = Event.solr_search do
      fulltext params[:events]
      any_of do
        with(:end_date).greater_than_or_equal_to(Time.zone.now.to_date)
      end 
      facet(:event_month, :sort => :count)
        with(:event_month, params[:month]) if params[:month].present?
      facet(:marker_list, :limit => 65, :sort => :count)
        with(:marker_list, params[:tag]) if params[:tag].present?
      facet(:location, :limit => 24, :sort => :count)
        with(:location, params[:locations]) if params[:locations].present?
    end
    @query = params[:events]
    @facet = params[:month]
    @tag_facet = params[:tag]
    @location_facet = params[:locations]
    @results = Event.where(id: @search.results.map(&:id)).page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def past
    @markers = Event.marker_counts.order('count DESC').limit(12)
    @events = Event.order('start_date desc').where("start_date < ? AND end_date < ?", Time.zone.now.to_date, Time.zone.now.to_date).page(params[:page]).per_page(20)
    @search = Event.solr_search do
      fulltext params[:events]
      any_of do
        with(:start_date).less_than_or_equal_to(Time.zone.now.to_date)
        with(:end_date).less_than_or_equal_to(Time.zone.now.to_date)
      end 
      facet(:event_month)
        with(:event_month, params[:month]) if params[:month].present?
      facet(:marker_list, :limit => 65, :sort => :count)
        with(:marker_list, params[:tag]) if params[:tag].present?
      facet(:location, :limit => 24, :sort => :count)
        with(:location, params[:locations]) if params[:locations].present?
    end
    @query = params[:events]
    @facet = params[:month]
    @tag_facet = params[:tag]
    @location_facet = params[:locations]
    @results = Event.where(id: @search.results.map(&:id)).page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    if @event
      @commentable = @event
      @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
      @comment = Comment.new
      @uploadable = @event
      @uploads = @uploadable.uploads.order('created_at desc').page(params[:page]).per_page(20)
      @upload = Upload.new
      @updateable = @event
      @updates = @updateable.updates.order('created_at desc').page(params[:page]).per_page(5)
      @update = Update.new
      @followers = @event.followers(:order => 'created_at DESC').paginate(page: params[:page], per_page: (15))
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @event }
      end
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    
  end

  # POST /events
  # POST /events.json
  def create

    @event = current_member.events.new(params[:event])

    respond_to do |format|
      if @event.save
        current_member.create_activity(@event, 'created')
        format.html { redirect_to @event }
        format.json { render json: @event, status: :created, location: @event }
        format.js   { render :js => "window.location.href = ('#{event_path(@event)}');"}
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
        format.js
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event }
        format.json { head :no_content }
        format.js   { render :js => "window.location.href = ('#{event_path(@event)}');"}
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
        format.js
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    
    @event.destroy

    respond_to do |format|
      format.html { redirect_to profile_events_path(current_member) }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @event = Event.find(params[:id])
    if current_member.voted_up_on? @event
      @event.unliked_by current_member
    else 
      @event.liked_by current_member
    end
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def popular
    @search = Event.solr_search do
      fulltext params[:events]
      facet(:event_month, :sort => :count)
        with(:event_month, params[:month]) if params[:month].present?
      facet(:marker_list, :limit => 65, :sort => :count)
        with(:marker_list, params[:tag]) if params[:tag].present?
      facet(:location, :limit => 24, :sort => :count)
        with(:location, params[:locations]) if params[:locations].present?
    end
    @query = params[:events]
    @facet = params[:month]
    @tag_facet = params[:tag]
    @location_facet = params[:locations]
    @results = Event.joins(:votes).group("events.id").having("count(votes.id) >= ?", 1).where(id: @search.results.map(&:id)).page(params[:page]).per_page(20)
    @events = Event.joins(:votes).group("events.id").having("count(votes.id) >= ?", 1).order("created_at desc").page(params[:page]).per_page(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

 private
  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

  def find_event
    @event = current_member.events.find(params[:id])
  end

  def locations_count
    locations_count = Hash.new{0}  
    Event.all.each { |event| locations_count[event.location] += 1 }  
    locations_count.sort_by { |key, value| value }  
  end 

end
