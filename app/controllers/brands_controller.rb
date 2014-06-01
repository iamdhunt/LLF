class BrandsController < ApplicationController

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_brand, only: [:edit, :update, :destroy]

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.order('name asc').page(params[:page]).per_page(54)
    @search = Brand.search do
      fulltext params[:search]
      facet(:marker_list, :limit => 25, :sort => :count)
      with(:marker_list, params[:tag]) if params[:tag].present?
    end
    @query = params[:search]
    @facet = params[:tag]
    @results = @search.results

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brands }
    end
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @brand = Brand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/new
  # GET /brands/new.json
  def new
    @brand = Brand.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/1/edit
  def edit
    
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = current_member.brands.new(params[:brand])

    respond_to do |format|
      if @brand.save
        current_member.create_activity(@brand, 'created')
        format.html { redirect_to @brand }
        format.json { render json: @brand, status: :created, location: @brand }
      else
        format.html { render action: "new" }
        format.json { render json: @brand.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
      end
    end
  end

  # PUT /brands/1
  # PUT /brands/1.json
  def update

    respond_to do |format|
      if @brand.update_attributes(params[:brand])
        format.html { redirect_to @brand }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @brand.errors, alert: 'Please make sure all required fields are filled in and all fields are formatted correctly.' }
      end
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @activity = Activity.find_by_targetable_id(params[:id])
    if @activity
      @activity.destroy
    end
    @brand.destroy

    respond_to do |format|
      format.html { redirect_to brands_url }
      format.json { head :no_content }
    end
  end

  def upvote
    @brand = Brand.find(params[:id])
    if current_member.voted_up_on? @brand
      @brand.unliked_by current_member
    else 
      @brand.liked_by current_member
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

    def find_brand
      @brand = current_member.brands.find(params[:id])
    end
end
