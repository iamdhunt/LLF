class FollowsController < ApplicationController
	before_filter :authenticate_member!

	def create
		unless followable == current_member
	    	current_member.follow(followable)
	    end
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
