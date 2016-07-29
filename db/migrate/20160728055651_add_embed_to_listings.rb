class AddEmbedToListings < ActiveRecord::Migration
  def change
    add_column :listings, :embed, :text
    add_column :listings, :button, :text
  end
end
