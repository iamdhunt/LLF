class ListingsController < ApplicationController

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_listing, only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.order('created_at desc').page(params[:page]).per_page(60)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    @commentable = @listing
    @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
    @comment = Comment.new

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/new
  # GET /listings/new.json
  def new
    @listing = Listing.new
    6.times { @listing.assets.build }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @listing }
    end
  end

  # GET /listings/1/edit
  def edit
    6.times { @listing.assets.build }
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = current_member.listings.new(params[:listing])

    respond_to do |format|
      if @listing.save
        current_member.create_activity(@listing, 'created')
        format.html { redirect_to @listing }
        format.json { render json: @listing, status: :created, location: @listing }
      else
        format.html { render action: "new" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /listings/1
  # PUT /listings/1.json
  def update

    respond_to do |format|
      if @listing.update_attributes(params[:listing])
        format.html { redirect_to @listing }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @activity = Activity.find_by_targetable_id(params[:id])
    @commentable = @event
    @comments = @commentable.comments
    if @activity
      @activity.destroy
    end
    if @comments
      @comments.destroy
    end
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
    end
  end

  def upvote
    @listing = Listing.find(params[:id])
    if current_member.voted_up_on? @listing
      @listing.unliked_by current_member
    else 
      @listing.liked_by current_member
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

    def find_listing
      @listing = current_member.listings.find(params[:id])
    end
end
