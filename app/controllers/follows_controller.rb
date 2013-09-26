class FollowsController < ApplicationController

	before_filter :authenticate_member!

	def create
    	@member = Member.find_by_user_name(params[:member_id])
    	current_member.follow(@member)
    	respond_to do |format|
	      format.html { redirect_to @member }
	      format.js 
	    end
 	end

  	def destroy
    	@member = Member.find_by_user_name(params[:member_id])
    	current_member.stop_following(@member)
    	respond_to do |format|
	      format.html { redirect_to @member }
	      format.js 
	    end
	end

end
