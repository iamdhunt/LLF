class MarketController < ApplicationController

	def market
		@listings = Listing.order('created_at desc').limit(32).page(params[:page]).per_page(60)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @brands }
	    end
	end 
	
end
