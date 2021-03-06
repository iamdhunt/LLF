class ActivitiesController < ApplicationController

  before_filter :authenticate_member!
  before_filter :find_activity, only: [:destroy]

  def index
    params[:page] ||= 1
    @activities = Activity.for_member(current_member, params)

    redirect_to root_path  
  end

  def destroy
    @targetable = @activity.targetable
		
    @targetable.destroy
	  @activity.destroy

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
      format.js
    end
  end

  def upvote
    @activity = Activity.find(params[:id])
    
    if current_member.voted_up_on? @activity
      @activity.unliked_by current_member
      unless @activity.targetable_type == 'Status'  
        @activity.targetable.unliked_by current_member
      end
    else 
      @activity.liked_by current_member
      unless @activity.targetable_type == 'Status'  
        @activity.targetable.liked_by current_member
      end
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
