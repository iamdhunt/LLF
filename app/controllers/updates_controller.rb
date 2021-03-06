class UpdatesController < ApplicationController

  before_filter :authenticate_member!
  before_filter :load_updateable
  before_filter :find_member

  def index
    redirect_to root_path
  end

  def new
  	@update = @updateable.updates.new
  end

  def create
    @update = @updateable.updates.new(params[:update])
    @updates = @updateable.updates.order('created_at desc').page(params[:page]).per_page(5)
    @update.member = current_member
    respond_to do |format|
      if @update.save
        format.html { redirect_to @updateable }
        format.json { render json: @updateable }
        format.js
      else
        format.html { redirect_to @updateable }
        format.json { render json: @updateable.errors, status: :unprocessable_entity }
        format.js
      end
    end 
  end

  def edit
    @update = current_member.updates.find(params[:id])
  end 

  def update
    @update = current_member.updates.find(params[:id])

    respond_to do |format|
      if @update.update_attributes(params[:update])
        format.html { redirect_to @updateable }
        format.json { head :no_content }
        format.js   { render :js => "window.location.href = ('#{polymorphic_path(@updateable)}');"}
      else
        format.html { render action: "edit" }
        format.json { render json: @update.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end 

  def destroy
    @update = Update.find(params[:id])
    respond_to do |format|
      if @update.member == current_member || @updateable.member == current_member
        @update.destroy
        format.html { redirect_to @updateable }
        format.json
        format.js
      else
        format.html { redirect_to @updateable, alert: 'You can\'t delete this update.' }
        format.json
        format.js
      end
    end 
  end

  private

  # def load_updateable
  #		resource, id = request.path.split('/')[1,2] # photos/1/
  #		@updateable = resource.singularize.classify.constantize.find(id) # Photo.find(1)
  # end 

  # alternative option:
  def load_updateable
  	klass = [Project, Event].detect { |c| params["#{c.name.underscore}_id"] }
  	@updateable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

end