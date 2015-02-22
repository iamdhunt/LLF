class MarketController < ApplicationController

	def market
		@member = Member.where({ user_name: "llfofficial"}).first
		@llf = @member.listings.order('created_at desc').limit(5)
		@listings = Listing.order('created_at desc').limit(40)
		@pop_lstgs = Listing.joins(:votes).group("listings.id").having("count(votes.id) >= ?", 1).order('created_at desc').limit(20)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json {  }
	    end
	end 
	
end
