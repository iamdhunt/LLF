class ProjectsController < ApplicationController
  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_project, only: [:edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @tags = Project.tag_counts.order('count DESC').limit(10)
    @search = Project.search do
      fulltext params[:search]
    end
    @projects = @search.results

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
    
    @project.destroy

    respond_to do |format|
      format.html { redirect_to profile_projects_path(current_member) }
      format.json { head :no_content }
    end
  end

  def media
    @project = Project.find(params[:id])
    @commentable = @project
    @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
    @comment = Comment.new
    @followers = @project.followers(:order => 'created_at DESC').paginate(page: params[:page], per_page: (72))
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @project }
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

end
