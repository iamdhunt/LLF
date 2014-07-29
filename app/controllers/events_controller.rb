class EventsController < ApplicationController
  # used for sanitization user's input
  REDACTOR_TAGS = %w(code span div label a br p b i del strike u img video audio
              iframe object embed param blockquote mark cite small ul ol li
              hr dl dt dd sup sub big pre code figure figcaption strong em
              table tr td th tbody thead tfoot h1 h2 h3 h4 h5 h6)
  REDACTOR_ATTRIBUTES = %w(href)

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_event, only: [:edit, :update]

  # GET /events
  # GET /events.json
  def index
    @markers = Event.marker_counts.order('count DESC').limit(12)
    @events = Event.order('start_date asc').where("start_date >= ?", Time.zone.now.to_date).page(params[:page]).per_page(54)
    @search = Event.solr_search do
      fulltext params[:search]
      any_of do
        with(:start_date).greater_than_or_equal_to(Time.zone.now.to_date)
        with(:end_date).greater_than_or_equal_to(Time.zone.now.to_date)
      end 
      facet(:event_month)
      with(:event_month, params[:month]) if params[:month].present?
      facet(:marker_list, :limit => 48, :sort => :count)
      with(:marker_list, params[:tag]) if params[:tag].present?
    end
    @query = params[:search]
    @facet = params[:month]
    @tag_facet = params[:tag]
    @results = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find_by_permalink(params[:id])
    if @event
      @commentable = @event
      @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
      @comment = Comment.new
      @uploadable = @event
      @uploads = @uploadable.uploads.order('created_at desc').page(params[:page]).per_page(40)
      @upload = Upload.new
      @updateable = @event
      @updates = @updateable.updates.order('created_at desc').page(params[:page]).per_page(40)
      @update = Update.new
      @followers = @event.followers(:order => 'created_at DESC').paginate(page: params[:page], per_page: (36))
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
    params[:event][:details] = sanitize_redactor(params[:event][:details])
    @event = current_member.events.new(params[:event])

    respond_to do |format|
      if @event.save
        current_member.create_activity(@event, 'created')
        format.html { redirect_to @event }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    params[:event][:details] = sanitize_redactor(params[:event][:details])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = current_member.events.find(params[:id])
    @activity = Activity.find_by_targetable_id(params[:id])
    @commentable = @event
    @comments = @commentable.comments
    @uploadable = @event
    @uploads = @uploadable.uploads
    @updateable = @event
    @updates = @updateable.updates
    if @activity
      @activity.destroy
    end
    if @comments
      @comments.destroy
    end
    if @uploads
      @uploads.destroy
    end
    if @updates
      @updates.destroy
    end
    @event.destroy

    respond_to do |format|
      format.html { redirect_to profile_events_path(current_member) }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @event = Event.find_by_permalink(params[:id])
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

 private
  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

  def find_event
    @event = current_member.events.find_by_permalink(params[:id])
  end

  def sanitize_redactor(orig_input)
    stripped = view_context.strip_tags(orig_input)
    if stripped.present? # this prevents from creating empty comments
      view_context.sanitize(orig_input, tags: REDACTOR_TAGS, attributes: REDACTOR_ATTRIBUTES)
    else
      nil
    end
  end

  def locations_count
    locations_count = Hash.new{0}  
    Event.all.each { |event| locations_count[event.location] += 1 }  
    locations_count.sort_by { |key, value| value }  
  end 

end
