class FollowsController < ApplicationController

	before_filter :authenticate_member!

	def create
    	@member = Member.find(params[:member_id])
    	current_member.follow(@member)
    	respond_to do |format|
	      format.html { redirect_to @member }
	      format.js { render :layout=>false, :content_type => 'application/javascript' }
	    end
 	end

  	def destroy
    	@member = Member.find(params[:member_id])
    	current_member.stop_following(@member)
    	respond_to do |format|
	      format.html { redirect_to @member }
	      format.js { render :layout=>false, :content_type => 'application/javascript' }
	    end
	end

end
