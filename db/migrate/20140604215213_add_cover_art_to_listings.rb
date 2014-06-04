class AddCoverArtToListings < ActiveRecord::Migration
  def change
  	add_attachment :listings, :cover
  end
end
