class ProjectsController < ApplicationController

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_project, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @markers = Project.marker_counts.order('count DESC').limit(12)
    @projects = Project.order('created_at desc').where(:created_at => 24.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(60) 
    @search = Project.solr_search do
      fulltext params[:projects]
      facet(:city, :limit => 24, :sort => :count)
        with(:city, params[:city]) if params[:city].present?
      facet(:marker_list, :limit => 65, :sort => :count)
        with(:marker_list, params[:tag]) if params[:tag].present?
    end
    @query = params[:projects]
    @facet = params[:tag]
    @city_facet = params[:city]
    @results = Project.where(id: @search.results.map(&:id)).page(params[:page]).per_page(60)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
    @project = Project.find(params[:id])
    if @project
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
    else 
      render file: 'public/404', status: 404, formats: [:html]
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

    @project = current_member.projects.new(params[:project])

    respond_to do |format|
      if @project.save
        current_member.create_activity(@project, 'created')
        format.html { redirect_to @project }
        format.json { render json: @project, status: :created, location: @project }
        format.js   { render :js => "window.location.href = ('#{project_path(@project)}');"}
      else
        format.html { render action: "new" }
        format.json { render json: @project.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
        format.js
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.json
  def update

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to @project }
        format.json { head :no_content }
        format.js   { render :js => "window.location.href = ('#{project_path(@project)}');"}
      else
        format.html { render action: "edit" }
        format.json { render json: @project.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
        format.js
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
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

  def popular
    @projects = Project.joins(:votes).group("projects.id").having("count(votes.id) >= ?", 1).order("created_at desc").where(:created_at => 12.months.ago..Time.zone.now.to_date).page(params[:page]).per_page(60)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @projects }
    end
  end

 private
  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

  def find_project
    @project = current_member.projects.find(params[:id])
  end

end
