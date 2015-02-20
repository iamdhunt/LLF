class SearchController < ApplicationController

  def search
  	@search = Member.solr_search do
      fulltext params[:discover]
		  facet(:city, :limit => 25, :sort => :count)
		    with(:city, params[:city]) if params[:city].present?
		  facet(:pursuit_list, :limit => 50, :sort => :count)
		    with(:pursuit_list, params[:pursuit]) if params[:pursuit].present?
    end
    @facet = params[:city]
    @tag_facet = params[:pursuit]
    @query = params[:discover]
    @results = Member.where(id: @search.results.map(&:id)).page(params[:page]).per_page(72)
    @members = Member.order_by_rand.limit(48).all
  end

end
