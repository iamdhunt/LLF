class FollowsController < ApplicationController

	before_filter :authenticate_member!

	def create
    	current_member.follow(followable)
    	respond_to do |format|
	      format.html # index.html.erb
	      format.js
	    end
 	end

  	def destroy
    	current_member.stop_following(followable)
	    respond_to do |format|
	      format.html # index.html.erb
	      format.js
	    end
	end

end
