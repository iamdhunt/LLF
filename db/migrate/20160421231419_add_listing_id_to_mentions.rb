class AddListingIdToMentions < ActiveRecord::Migration
  def change
    add_column :mentions, :listing_id, :integer
  end
end
