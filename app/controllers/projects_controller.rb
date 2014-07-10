class ProjectsController < ApplicationController
  # used for sanitization user's input
  REDACTOR_TAGS = %w(code span div label a br p b i del strike u img video audio
              iframe object embed param blockquote mark cite small ul ol li
              hr dl dt dd sup sub big pre code figure figcaption strong em
              table tr td th tbody thead tfoot h1 h2 h3 h4 h5 h6)
  REDACTOR_ATTRIBUTES = %w(href)

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_project, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @markers = Project.marker_counts.order('count DESC').limit(12)
    @projects = Project.order('created_at desc').where(:created_at => 3.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(54) 
    @search = Project.search do
      fulltext params[:search]
      facet(:marker_list, :limit => 48, :sort => :count)
      with(:marker_list, params[:tag]) if params[:tag].present?
    end
    @query = params[:search]
    @facet = params[:tag]
    @results = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    @commentable = @project
    @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
    @comment = Comment.new
    @uploadable = @project
    @uploads = @uploadable.uploads.order('created_at desc').page(params[:page]).per_page(40)
    @upload = Upload.new
    @updateable = @project
    @updates = @updateable.updates.order('created_at desc').page(params[:page]).per_page(5)
    @update = Update.new
    @followers = @project.followers(:order => 'created_at DESC').paginate(page: params[:page], per_page: (36))
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.json
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @project }
    end
  end

  # GET /projects/1/edit
  def edit
    
  end

  # POST /projects
  # POST /projects.json
  def create
    params[:project][:about] = sanitize_redactor(params[:project][:about])
    @project = current_member.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        current_member.create_activity(@project, 'created')
        format.html { redirect_to @project }
        format.json { render json: @project, status: :created, location: @project }
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update
    params[:project][:about] = sanitize_redactor(params[:project][:about])
    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @activity = Activity.find_by_targetable_id(params[:id])
    @commentable = @project
    @comments = @commentable.comments
    @uploadable = @project
    @uploads = @uploadable.uploads
    @updateable = @project
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
    @project.destroy

    respond_to do |format|
      format.html { redirect_to profile_projects_path(current_member) }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @project = Project.find(params[:id])
    if current_member.voted_up_on? @project
      @project.unliked_by current_member
    else 
      @project.liked_by current_member
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

  def find_project
    @project = current_member.projects.find(params[:id])
  end

  def sanitize_redactor(orig_input)
    stripped = view_context.strip_tags(orig_input)
    if stripped.present? # this prevents from creating empty comments
      view_context.sanitize(orig_input, tags: REDACTOR_TAGS, attributes: REDACTOR_ATTRIBUTES)
    else
      nil
    end
  end

end
