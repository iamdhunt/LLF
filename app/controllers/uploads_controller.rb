class UploadsController < ApplicationController

before_filter :authenticate_member!
before_filter :load_uploadable, only: [:index, :show, :new, :create, :destroy]
before_filter :find_member

  def index
    redirect_to root_path
  end

  def show

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
      format.js
    end
  end

  def new
  	@upload = @uploadable.uploads.new
  end

  def create
    @upload = @uploadable.uploads.new(params[:upload])
    @upload.member = current_member
    respond_to do |format|
      if @upload.save
        format.html { redirect_to @uploadable }
        format.json { render json: @uploadable }
        format.js
      else
        format.html { redirect_to @uploadable }
        format.json { render json: @uploadable.errors, status: :unprocessable_entity }
        format.js
      end
    end 
  end

  def destroy
    @upload = Upload.find(params[:id])
    respond_to do |format|
      if @upload.member == current_member || @uploadable.member == current_member
         @upload.destroy
         format.html { redirect_to :back }
         format.js
      else
         format.html { redirect_to :back, alert: 'You can\'t delete this upload.' }
         format.js
      end
    end 
  end

  def cancel

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @medium }
      format.js
    end
  end

  private

  # def load_uploadable
  #		resource, id = request.path.split('/')[1,2] # photos/1/
  #		@uploadable = resource.singularize.classify.constantize.find(id) # Photo.find(1)
  # end 

  # alternative option:
  def load_uploadable
  	klass = [Project, Event].detect { |c| params["#{c.name.underscore}_id"] }
  	@uploadable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

end