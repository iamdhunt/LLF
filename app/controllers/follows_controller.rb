class FollowsController < ApplicationController

	before_filter :authenticate_member!

	def create
    	@member = Member.find(params[:member_id])
    	current_member.follow(@member)
 	 end

  	def destroy
    	@member = Member.find(params[:member_id])
    	current_member.stop_following(@member)
	end

end
