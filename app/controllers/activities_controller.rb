class ActivitiesController < ApplicationController

  before_filter :authenticate_member!
  before_filter :find_activity, only: [:destroy]

  def index
  	following_ids = current_member.following_members.map(&:id)
  	@activities = Activity.where("member_id in (?)", following_ids.push(current_member.id)).order("created_at desc").all
  end

  def destroy
  	@status = @activity.targetable
		if @status && @activity.targetable_type == 'Status'	
			@status.destroy
		end
	@activity.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

  def find_activity
  	@activity = current_member.activities.find(params[:id])
  end 

end
