class MarketController < ApplicationController

	def market
		@member = Member.find(1)
		@llf = @member.listings.order('created_at desc').limit(12)
		@listings = Listing.order('created_at desc').limit(40)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @brands }
	    end
	end 
	
end
