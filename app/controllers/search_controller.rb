class SearchController < ApplicationController

before_filter :authenticate_member!

  def search
  	@search = Member.search do
      fulltext params[:search]
       paginate :page => 1, :per_page => 72
    end 
    @query = params[:search]
    @members = @search.results
  end

end
