class MarketController < ApplicationController

	def market
		@member = Member.find(9)
		@llf = @member.listings.order('created_at desc').limit(8)
		@listings = Listing.order('created_at desc').limit(24)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @brands }
	    end
	end 
	
end
