class ActivitiesController < ApplicationController
  def index
  	following_ids = current_member.following_members.map(&:id)
  	@activities = Activity.where("member_id in (?)", following_ids.push(current_member.id)).order("created_at desc")
  end

end
