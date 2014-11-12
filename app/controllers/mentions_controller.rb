class MentionsController < ApplicationController
	before_filter :authenticate_member!
	before_filter :load_mentionable
	before_filter :find_member

  	def new
  		@mention = @mentionable.mentions.new
  	end

  	def create
  		@mention = @mentionable.mentions.new(params[:mention])
	    respond_to do |format|
	      if @mention.save
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

  	private 

  	def load_mentionable
	  	klass = [Status].detect { |c| params["#{c.name.underscore}_id"] }
	  	@mentionable = klass.find(params["#{klass.name.underscore}_id"])
	end

	def find_member
	    @member = Member.find_by_user_name(params[:user_name])
	end 

end
