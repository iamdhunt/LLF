class StatusesController < ApplicationController

  before_filter :authenticate_member!, only: [:index, :new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_status, only: [:edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound do
    render file: 'public/404', status: 404, formats: [:html]
  end


  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.order('created_at desc').page(params[:page]).per_page(21)
    
    redirect_to root_path
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])
    if @status
      @commentable = @status
      @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
      @comment = @commentable.comments.new
      respond_to do |format|
        format.html # show.html.erb
        format.json { redirect_to profile_path(current_member) }
      end
    else 
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  # GET /statuses/new
  # GET /statuses/new.json
  def new
    @status = current_member.statuses.new
    @status.build_document

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
      format.js
    end
  end

  # GET /statuses/1/edit
  def edit
    
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = current_member.statuses.new(params[:status])

    respond_to do |format|
      if @status.save
        @activity = current_member.create_activity(@status, 'created')
        format.html { redirect_to :back }
        format.json
        format.js
      else
        format.html { redirect_to profile_path(current_member), alert: 'Post wasn\'t created. Please try again and ensure image attchments are under 10Mbs.'  }
        format.json { render json: @status.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  def update
    @document = @status.document
    if params[:status] && params[:status].has_key?(:user_id)
        params[:status].delete(:user_id) 
    end 
    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to status_path(@status) }
        format.json { head :no_content }
        format.js   { render :js => "window.location.href = ('#{status_path(@status)}');"}
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    
    @status.destroy

    respond_to do |format|
      format.html { redirect_to profile_path(current_member) }
      format.json { head :no_content }
    end
  end

  private
    def find_member
      @member = Member.find_by_user_name(params[:user_name])
    end 

    def find_status
      @status = current_member.statuses.find(params[:id])
    end 

    def sortable_date
      created_at
    end 

end
