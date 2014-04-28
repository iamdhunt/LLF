class FollowsMembersController < FollowsController

  def followable
    @followable ||= Member.find_by_user_name(params[:member_id])
  end
  
end