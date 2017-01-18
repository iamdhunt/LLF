class ErrorsController < ApplicationController
  skip_before_filter :authenticate_member!

  def not_found
  	render :status => 404
  end

end
