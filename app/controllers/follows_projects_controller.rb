class FollowsProjectsController < FollowsController

  def followable
    @followable ||= Project.find(params[:project_id])
  end
  
end