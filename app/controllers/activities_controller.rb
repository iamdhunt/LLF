class ActivitiesController < ApplicationController

  before_filter :authenticate_member!
  before_filter :find_activity, only: [:destroy]

  def index
  	params[:page] ||= 1
  	@activities = Activity.for_member(current_member, params)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def destroy
    @status = @activity.targetable
		if @activity.targetable_type == 'Status'	
			@status.destroy
		end
	@activity.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  def upvote
    @activity = Activity.find(params[:id])
    if current_member.voted_up_on? @activity
      @activity.unliked_by current_member
    else 
      @activity.liked_by current_member
    end
    respond_to do |format|
        format.html { redirect_to :back }
        format.js
    end
  end

  private

  def find_activity
  	@activity = current_member.activities.find(params[:id])
  end 

end
