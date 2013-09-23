class FollowsController < ApplicationController

	before_filter :authenticate_member!, only: [:new, :create, :edit, :update]

	def create
    	@member = Member.where(user_name: params[:id])
    	current_member.follow(@member)
 	 end

  	def destroy
    	@member = Member.where(user_name: params[:id])
    	current_member.stop_following(@member)
	end

end
