class SearchController < ApplicationController

  def search
  	@search = Member.solr_search do
      fulltext params[:search]
		facet(:city, :limit => 24, :sort => :count)
		with(:city, params[:city]) if params[:city].present?
		facet(:pursuit_list, :limit => 48, :sort => :count)
		with(:pursuit_list, params[:tag]) if params[:tag].present?
    end 
    @query = params[:search]
    @members = Member.where(id: @search.results.map(&:id)).page(params[:page]).per_page(72)
    @search_total = @members.total_entries
  end

end
