class SearchController < ApplicationController

  def search
  	@search = Member.solr_search do
      fulltext params[:search]
       paginate :page => 1, :per_page => 72
    end 
    @query = params[:search]
    @members = @search.results
    @search_total = @members.total_entries
  end

end
