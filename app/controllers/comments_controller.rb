class CommentsController < ApplicationController

before_filter :authenticate_member!
before_filter :load_commentable
before_filter :find_member

  def index
    redirect_to root_path
  end

  def new
  	@comment = @commentable.comments.new
  end

  def create
    @comment = @commentable.comments.new(params[:comment])
    @comments = @commentable.comments.order('created_at desc').page(params[:page]).per_page(15)
    @comment.member = current_member
    respond_to do |format|
      if @comment.save
        format.html { redirect_to :back }
        format.json
        format.js
      else
        format.html { redirect_to :back }
        format.json
        format.js
      end
    end 
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.member == current_member || @commentable.member == current_member
        @comment.destroy
        format.html { redirect_to :back }
        format.json
        format.js
      else
        format.html { redirect_to :back, alert: 'You can\'t delete this comment.' }
        format.json
        format.js
      end
    end 
  end

  private

  # def load_commentable
  #		resource, id = request.path.split('/')[1,2] # photos/1/
  #		@commentable = resource.singularize.classify.constantize.find(id) # Photo.find(1)
  # end 

  # alternative option:
  def load_commentable
  	klass = [Status, Medium, Project, Event, Listing].detect { |c| params["#{c.name.underscore}_id"] }
  	@commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  #def load_commentable
  #  @commentable = params[:commentable_type].camelize.constantize.find(params[:commentable_id])
  #end

  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

end