class AddBannerToListings < ActiveRecord::Migration
  def change
  	add_attachment :listings, :banner
  end
end
