class AddMarkersToListings < ActiveRecord::Migration
  def change
    add_column :listings, :markers, :text
  end
end
