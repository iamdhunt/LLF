class MarketController < ApplicationController

	def market

		respond_to do |format|
	      format.html # index.html.erb
	      format.json { render json: @brands }
	    end
	end 
	
end
