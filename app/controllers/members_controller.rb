class MembersController < ApplicationController
  
   before_filter :authenticate_member!

  def index
    @member = Member.find(current_member)
    
    @member = Member.all
  end

  def show
    @member = Member.find_by_user_name(params[:id])
    	if @member 
	  		@statuses = @member.statuses.all
	  		render action: :show
  		else
  			render file: 'public/404', status: 404, formats: [:html]
  		end
  end

end
