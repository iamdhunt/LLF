class FollowsEventsController < FollowsController

  def followable
    @followable ||= Event.find(params[:event_id])
  end
  
end