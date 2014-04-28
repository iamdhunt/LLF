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
    @comment.member = current_member
    if @comment.save
      redirect_to :back
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    respond_to do |format|
      if @comment.member == current_member || @commentable.member == current_member
         @comment.destroy
         format.html { redirect_to :back }
      else
         format.html { redirect_to :back, alert: 'You can\'t delete this comment.' }
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
  	klass = [Status, Medium, Project].detect { |c| params["#{c.name.underscore}_id"] }
  	@commentable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

end