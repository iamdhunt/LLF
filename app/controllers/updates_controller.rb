class UpdatesController < ApplicationController
  # used for sanitization user's input
  REDACTOR_TAGS = %w(code span div label a br p b i del strike u img video audio
              iframe object embed param blockquote mark cite small ul ol li
              hr dl dt dd sup sub big pre code figure figcaption strong em
              table tr td th tbody thead tfoot h1 h2 h3 h4 h5 h6)
  REDACTOR_ATTRIBUTES = %w(href)

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
    params[:update][:content] = sanitize_redactor(params[:update][:content])
    @update = @updateable.updates.new(params[:update])
    @update.member = current_member
    respond_to do |format|
      if @update.save
        format.html { redirect_to @updateable }
        format.json { render json: @updateable }
      else
        format.html { redirect_to @updateable }
        format.json { render json: @updateable.errors, status: :unprocessable_entity }
      end
    end 
  end

  def destroy
    @update = Update.find(params[:id])
    respond_to do |format|
      if @update.member == current_member || @updateable.member == current_member
         @update.destroy
         format.html { redirect_to :back }
      else
         format.html { redirect_to :back, alert: 'You can\'t delete this update.' }
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
  	klass = [Project].detect { |c| params["#{c.name.underscore}_id"] }
  	@updateable = klass.find(params["#{klass.name.underscore}_id"])
  end

  def find_member
    @member = Member.find_by_user_name(params[:user_name])
  end 

  def sanitize_redactor(orig_input)
    stripped = view_context.strip_tags(orig_input)
    if stripped.present? # this prevents from creating empty comments
      view_context.sanitize(orig_input, tags: REDACTOR_TAGS, attributes: REDACTOR_ATTRIBUTES)
    else
      nil
    end
  end

end