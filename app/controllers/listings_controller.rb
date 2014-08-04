class ListingsController < ApplicationController

  before_filter :authenticate_member!, only: [:new, :create, :edit, :update, :destroy] 
  before_filter :find_member
  before_filter :find_listing, only: [:edit, :update, :destroy]

  # GET /listings
  # GET /listings.json
  def index
    @listings = Listing.order('created_at desc').page(params[:page]).per_page(60)
    @search = Listing.solr_search do
      fulltext params[:listings]
      facet(:marker_list, :limit => 48, :sort => :count)
      with(:marker_list, params[:tag]) if params[:tag].present?
      facet(:price) do
        row("$0 - $25") do
          with(:price, 0.00..25.00)
        end
        row("$25 - $75") do
          with(:price, 25.01..75.00)
        end
        row("$75 - $250") do
          with(:price, 75.01..250.00)
        end
        row("$250+") do
          with(:price).greater_than(250.00)
        end
      end
      with(:price, params[:price]) if params[:price].present?
    end
    @query = params[:listings]
    @facet = params[:tag]
    @price_facet = params[:price]
    @results = Listing.where(id: @search.results.map(&:id)).page(params[:page]).per_page(60)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @listings }
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
    if @listing
      @additional = @listing.member.listings.order("RANDOM()").limit(6)
      @commentable = @listing
      @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
      @comment = Comment.new

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @listing }
      end
    else 
      render file: 'public/404', status: 404, formats: [:html]
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
   
    @listing.destroy

    respond_to do |format|
      format.html { redirect_to listings_url }
      format.json { head :no_content }
      format.js
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
