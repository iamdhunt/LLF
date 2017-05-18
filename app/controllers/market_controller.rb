class MarketController < ApplicationController

	def market
		@listings = Listing.order('created_at desc').limit(20)
		@pop_lstgs = Listing.joins(:votes).group("listings.id").having("count(votes.id) >= ?", 1).order('created_at desc').limit(10)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json {  }
	    end
	end 
	
end
