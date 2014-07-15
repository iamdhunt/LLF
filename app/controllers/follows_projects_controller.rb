class FollowsProjectsController < FollowsController
	before_filter :load_commentable
	before_filter :comment

	def followable
  	@followable ||= Project.find(params[:project_id])
	end

	private 

  	def load_commentable
  		klass = [Status, Medium, Project, Event, Listing].detect { |c| params["#{c.name.underscore}_id"] }
  		@commentable = klass.find(params["#{klass.name.underscore}_id"])
  	end

  	def comment
  		@comment = @commentable.comments.new(params[:comment])
  	end
  
end