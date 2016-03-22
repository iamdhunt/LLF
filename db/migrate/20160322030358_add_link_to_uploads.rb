class AddLinkToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :link, :text
  end
end
