class MarketController < ApplicationController

	def market
		@member = Member.where({ user_name: "iamdhunt"}).first
		@llf = @member.listings.order('created_at desc').limit(8)
		@listings = Listing.order('created_at desc').limit(24)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json {  }
	    end
	end 
	
end
