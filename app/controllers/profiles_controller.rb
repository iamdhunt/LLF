class ProfilesController < ApplicationController
 
  def show
  	@status = Status.new
    @status.build_document
  	@member = Member.find_by_user_name(params[:id])
  	if @member 
  		@statuses = Status.order('created_at desc').all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end

  def media
    @medium = current_member.medium.new
    @member = Member.find_by_user_name(params[:id])
    if @member 
      @media = @member.medium.order('created_at desc').all 
      render action: :media
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  def media_new
    @medium = current_member.medium.new
    @member = Member.find_by_user_name(params[:id])
    if @member && @member == current_member
      render action: :media_new
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end
  
end
