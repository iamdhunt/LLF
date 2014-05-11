class AddCaptionToUploads < ActiveRecord::Migration
  def change
  	add_column :uploads, :caption, :text
  end
end
