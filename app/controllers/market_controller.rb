class MarketController < ApplicationController

	def market
		@brands = Brand.order("RANDOM()").limit(12)

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @brands }
	    end
	end 
	
end
